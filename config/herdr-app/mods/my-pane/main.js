// A pane's header, for layouts that frame their panes:
//   { "tab": "active", "pane": { "header": { "content": { "mod": "my-pane" } } } }
// Shows the program's icon (the app's program table), the agent's name or
// the terminal's title, the folder, and the agent's status; buttons split, zoom and close
// this pane, plus one that opens the folder in VS Code. Props from the app: { pane, terminal }.
// Click: focus the pane.

import { View, div, svg, image } from "gpui-kit";
import { h_flex } from "gpui-base";
import { panes, props, run, theme, home, layout, spaces, exec, notify } from "herdr";

// Match the first visible tab frame, including the active child of a stack.
function paneFrame(node) {
  if (!node || node.hidden) return null;
  if (node.content?.tab && node.content.pane) return node.content.pane;
  let children = node.children ?? [];
  if (node.type === "stack") {
    const visible = children.filter(child => !child.hidden);
    children = [visible.find(child => child.id === node.active) ?? visible[0]];
  }
  for (const child of children) {
    const frame = paneFrame(child);
    if (frame) return frame;
  }
  return null;
}

function icon(p, size, color) {
  if (!p?.icon) return null;
  return p.tint ? svg(p.icon).size(size).flex_none().text_color(color) : image(p.icon).w(size).h(size).flex_none();
}

function folder(cwd) {
  if (!cwd) return "";
  const h = home();
  return cwd === h ? "~" : cwd.startsWith(h + "/") ? "~" + cwd.slice(h.length) : cwd;
}

// The machine a pane lives on: null for this computer.
function machineOf(pane) {
  for (const space of spaces()) {
    if (space.tabs.some((tab) => tab.id === pane.tab)) return space.machine;
  }
  return null;
}

// The .code-workspace files for a folder: the ones in it, or, if it has none,
// the nearest ones above it, up to the repo root (or home).
const WORKSPACE_LOOKUP = 'd="$1"; while :; do found=$(ls -1 "$d"/*.code-workspace 2>/dev/null); if [ -n "$found" ]; then printf "%s\\n" "$found"; break; fi; [ "$d" = "$HOME" ] && break; [ -d "$d/.git" ] && break; p=$(dirname "$d"); [ "$p" = "$d" ] && break; d="$p"; done; exit 0';

async function workspaceFiles(folder, machine) {
  try {
    const r = await exec("bash", ["-c", WORKSPACE_LOOKUP, "bash", folder], machine ? { on: machine } : { timeout: 5000 });
    return r.stdout.split("\n").map((line) => line.trim()).filter(Boolean);
  } catch {
    return [];
  }
}

// Opens the pane's folder in VS Code.
// The editor is detached (setsid --fork) with its output away from here, so
// Herdr never waits on it and the editor outlives this window.
async function openInVSCode(pane) {
  const cwd = pane.cwd;
  if (!cwd) {
    notify({ title: "VS Code", body: "This pane has no folder yet.", level: "warning" });
    return;
  }
  try {
    const check = await exec("bash", ["-c", "command -v code >/dev/null"], { timeout: 5000 });
    if (check.code !== 0) {
      notify({ title: "VS Code", body: "code is not on the PATH here.", level: "error" });
      return;
    }
  } catch (e) {
    notify({ title: "VS Code", body: String(e && e.message ? e.message : e), level: "error" });
    return;
  }
  const machine = machineOf(pane);
  // A workspace file in the folder is what the editor should open, not the folder.
  const workspaces = await workspaceFiles(cwd, machine);
  const workspace = workspaces[0] ?? null;
  if (workspace) {
    const name = workspace.split("/").pop();
    notify({ title: "VS Code", body: workspaces.length > 1 ? `${name} (of ${workspaces.length} workspace files)` : name, level: "info" });
  }
  const target = machine ? ["--remote", `${machine}:${workspace ?? cwd}`] : [workspace ?? cwd];
  exec("bash", ["-c", 'setsid --fork code "$@" >/dev/null 2>&1 </dev/null &', "code", ...target], { timeout: 5000 })
    .catch(() => {});
}

export default class Pane extends View {
  init() { this.hovered = false; }

  me() {
    return panes().find((p) => p.pane === props()?.pane);
  }

  button(t, id, icon, command, args) {
    return div()
      .id(id)
      .p(3)
      .rounded(4)
      .text_color(t.dim)
      .hover((s) => s.bg(t.hover).text_color(t.foreground))
      .on_click((_e, cx) => {
        cx.stop_propagation();
        run(command, args);
      })
      .child(svg(`mods/my-pane/${icon}.svg`).size(14));
  }

  editorButton(t, id, info) {
    return div()
      .id(id)
      .p(3)
      .rounded(4)
      .flex_none()
      .text_color(t.dim)
      .hover((s) => s.bg(t.hover).text_color(t.foreground))
      .tooltip("Open this folder in VS Code")
      .on_click((_e, cx) => {
        cx.stop_propagation();
        cx.spawn(async () => { await openInVSCode(info); });
      })
      .child(svg("mods/my-pane/vscode.svg").size(14));
  }

  render(cx) {
    const t = theme();
    const p = this.me();
    if (!p) return div();
    const name = ((p.program?.agent || p.program?.shell) && p.program.name) || p.title || p.program?.name || "shell";
    const pic = icon(p.program, 14, t.dim);
    const st = p.status;
    const pane = p.pane;
    const bottom = paneFrame(layout())?.header?.position === "bottom";
    return h_flex()
      .id(`pane-head-${pane}`)
      .size_full()
      .px(10)
      .gap(8)
      .items_center()
      .bg(t.background)
      .when(bottom, el => el.border_t(1))
      .when(!bottom, el => el.border_b(1))
      .border_color(t.border)
      .text_size(12)
      .on_hover((hovered, cx) => { this.hovered = hovered; cx.notify(); })
      .on_click(() => run("pane.focus", { pane }))
      .when(Boolean(pic), (el) => el.child(pic))
      .child(div().flex_none().truncate().max_w(260).font_medium().text_color(t.foreground).child(name))
      .child(div().flex_1().truncate().text_color(t.dim).child(folder(p.cwd)))
      .when(st === "working", el => el.child(svg("mods/workspace-chrome/spinner.svg").size(12).flex_none().text_color(t.working).spin(900)))
      .when(st === "blocked", el => el.child(div().flex_none().px(6).h(18).flex().items_center().rounded(5).bg(t.blocked + "26").text_size(10.5).font_semibold().text_color(t.blocked).child("Needs you")))
      .when(st === "done", el => el.child(div().size(7).flex_none().rounded(4).bg(t.done)))
      .when(this.hovered, el => el
        .child(this.editorButton(t, `ph-vc-${pane}`, p))
        .child(this.button(t, `ph-r-${pane}`, "split-right", "pane.split", { direction: "right", pane }))
        .child(this.button(t, `ph-d-${pane}`, "split-down", "pane.split", { direction: "down", pane }))
        .child(this.button(t, `ph-z-${pane}`, p.zoomed ? "unzoom" : "zoom", "pane.zoom", { pane }))
        .child(this.button(t, `ph-x-${pane}`, "close", "pane.close", { pane })));
  }
}
