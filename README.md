
## Setup

Put this inside your init.lua file:

```version = "0.17.3"
package.path = os.getenv("HOME") .. '/.config/xplr/plugins/?/src/init.lua'

require("rc").setup{
  onentry = "previewbg_new",
  onexit  = "restorebg"
}
```
