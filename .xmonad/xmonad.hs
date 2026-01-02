-- vim:set et sw=2:

import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.EwmhDesktops hiding (fullscreenEventHook)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers 
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Layout
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Renamed
import XMonad.Util.EZConfig
import XMonad.Actions.CycleWS
import qualified XMonad.StackSet as W
import XMonad.Layout.IndependentScreens

main =
  xmonad 
    . fullscreenSupport 
    . ewmh 
    $ desktopConfig
      { terminal = term
      , modMask = modm
      , focusFollowsMouse = False
      , normalBorderColor = "#37474f"
      , focusedBorderColor = "#06989A"
      , manageHook = manageDocks
      , workspaces = withScreens 2 ["1", "2", "3"]
      } 
      `additionalKeys`
      [ ((modm,               xK_1), windows $ onCurrentScreen W.greedyView "1")
      , ((modm,               xK_2), windows $ onCurrentScreen W.greedyView "2")
      , ((modm,               xK_3), windows $ onCurrentScreen W.greedyView "3")
      ]
      ++
      [ ((modm,               xK_BackSpace), spawn term)
      ] 
        where modm = mod4Mask
              term = "urxvt"
