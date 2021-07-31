-- vim:set et sw=2:

import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.EwmhDesktops hiding (fullscreenEventHook)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers 
import XMonad.Layout
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Util.EZConfig

layouts = toggle $ tallLayout ||| wideLayout ||| fullLayout
  where
    basicLayout = smartBorders $ fullscreenFocus $ Tall 1 (3/100) (1/2)
    tallLayout  = avoidStruts $ basicLayout
    wideLayout  = avoidStruts $ Mirror $ basicLayout
    fullLayout  = avoidStruts $ noBorders Full
    toggle = toggleLayouts fullLayout

manageHooks :: ManageHook
manageHooks = composeAll
     [ isDialog --> doCenterFloat
     , className =? "Xmessage" --> doCenterFloat
     , className =? "Pavucontrol" --> doFloat
     , className =? "Arandr" --> doFloat
     ] 

main = do 
  spawn "xmobar"

  xmonad $ fullscreenSupport $ ewmh $ desktopConfig
    { terminal = "urxvt"
    , modMask = modm
    , focusFollowsMouse = False
    , normalBorderColor = "#37474f"
    , focusedBorderColor = "#06989A"
    , layoutHook = desktopLayoutModifiers layouts
    , manageHook = manageHooks
    } 
    `additionalKeys`
    [ ((modm              , xK_f), sendMessage (Toggle "Full"))
    , ((modm .|. shiftMask, xK_f), sendMessage ToggleStruts) 
    ] 
    where modm = mod4Mask
