-- vim:set et sw=2:

import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.EwmhDesktops hiding (fullscreenEventHook)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers 
import XMonad.Hooks.DynamicLog
import XMonad.Layout
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Named
import XMonad.Util.EZConfig

layouts = toggle $ tallLayout ||| wideLayout ||| fullLayout
  where
    basicLayout = smartBorders $ fullscreenFocus $ Tall 1 (3/100) (1/2)
    tallLayout  = named "Tall" $ avoidStruts $ basicLayout
    wideLayout  = named "Wide" $ avoidStruts $ Mirror basicLayout
    fullLayout  = named "Full" $ avoidStruts $ noBorders Full
    toggle = toggleLayouts fullLayout

manageHooks :: ManageHook
manageHooks = composeAll
     [ isDialog --> doCenterFloat
     , className =? "Xmessage" --> doCenterFloat
     , className =? "Pavucontrol" --> doFloat
     , className =? "Arandr" --> doFloat
     ] 

main = do 
  spawn "xmobar $HOME/.xmonad/xmobar.hs"

  xmonad $ fullscreenSupport $ ewmh $ desktopConfig
    { terminal = "urxvt"
    , modMask = modm
    , focusFollowsMouse = False
    , normalBorderColor = "#37474f"
    , focusedBorderColor = "#06989A"
    , layoutHook = desktopLayoutModifiers layouts
    , manageHook = manageHooks
    , logHook = dynamicLogString def >>= xmonadPropLog
    } 
    `additionalKeys`
    [ ((modm              , xK_f), sendMessage (Toggle "Full"))
    , ((modm .|. shiftMask, xK_f), sendMessage ToggleStruts) 
    ] 
    where modm = mod4Mask
