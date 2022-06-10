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

layouts = toggle $ tallLayout ||| wideLayout ||| fullLayout
  where
    basicLayout = smartBorders $ fullscreenFocus $ Tall 1 (3/100) (1/2)
    tallLayout  = renamed [Replace "Tall"] $ avoidStruts $ basicLayout
    wideLayout  = renamed [Replace "Wide"] $ avoidStruts $ Mirror basicLayout
    fullLayout  = renamed [Replace "Full"] $ avoidStruts $ noBorders Full
    toggle = toggleLayouts fullLayout

manageHooks :: ManageHook
manageHooks = composeAll
     [ isDialog --> doCenterFloat
     , className =? "Xmessage" --> doCenterFloat
     , className =? "Pavucontrol" --> doFloat
     , className =? "Arandr" --> doFloat
     ] 

main = do 
  spawn "xmobar $HOME/.xmobar/xmobar.hs"

  xmonad 
    . fullscreenSupport 
    . ewmh 
    . withUrgencyHook NoUrgencyHook 
    $ desktopConfig
      { terminal = term
      , modMask = modm
      , focusFollowsMouse = False
      , normalBorderColor = "#37474f"
      , focusedBorderColor = "#06989A"
      , layoutHook = desktopLayoutModifiers layouts
      , manageHook = manageHooks
      , workspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
      , logHook = dynamicLogString def {
          ppUrgent = xmobarColor "red" "" . wrap "!" "!"
                                       } >>= xmonadPropLog
      } 
      `additionalKeys`
      [ ((modm              , xK_f), sendMessage (Toggle "Full"))
      , ((modm .|. shiftMask, xK_f), sendMessage ToggleStruts) 
      , ((modm,               xK_BackSpace), spawn term)
      , ((modm,               xK_bracketright), moveTo Next NonEmptyWS)
      , ((modm,               xK_bracketleft), moveTo Prev NonEmptyWS)
      , ((modm,               xK_backslash), toggleWS)
      , ((modm,               xK_y), windows $ W.greedyView "7")
      , ((modm,               xK_u), windows $ W.greedyView "8")
      , ((modm,               xK_i), windows $ W.greedyView "9")
      , ((modm,               xK_o), windows $ W.greedyView "0")
      , ((modm,               xK_0), windows $ W.greedyView "0")
      , ((modm .|. shiftMask, xK_0), windows $ W.shift "0")
      ] 
        where modm = mod4Mask
              term = "urxvt"
