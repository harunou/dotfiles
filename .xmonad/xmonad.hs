import System.Exit
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.BinarySpacePartition (emptyBSP)
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.ResizableTile (ResizableTall(..))
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)

main = xmonad $ desktopConfig
  { terminal = "urxvt"
  , modMask = modm
  , focusFollowsMouse = False
  , layoutHook = desktopLayoutModifiers $ defaultTall ||| noBorders (Full) ||| Mirror (defaultTall)
  }
    where modm = mod4Mask,
          defaultTall = Tall 1 3/100 1/2
