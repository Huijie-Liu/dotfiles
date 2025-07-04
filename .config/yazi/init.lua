-- full border plugin
require("full-border"):setup()

-- git status plugin
th.git = th.git or {}

th.git.modified   = ui.Style():fg("blue")
th.git.added      = ui.Style():fg("green")
th.git.untracked  = ui.Style():fg("cyan"):bold()
th.git.ignored    = ui.Style():fg("gray")
th.git.deleted    = ui.Style():fg("red"):bold()
th.git.updated    = ui.Style():fg("magenta")

th.git.modified_sign   = "M"   -- unstaged/modified
th.git.added_sign      = "A"   -- staged/added
th.git.untracked_sign  = "?"   -- untracked
th.git.ignored_sign    = "I"   -- ignored
th.git.deleted_sign    = "D"   -- deleted
th.git.updated_sign    = "U"   -- renamed/updated

require("git"):setup()
