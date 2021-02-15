-- vim:set et sw=2:

import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.EwmhDesktops hiding (fullscreenEventHook)
import XMonad.Hooks.ManageDocks
import XMonad.Layout
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders

myLayout = desktopLayoutModifiers $ tallLayout ||| wideLayout ||| fullLayout
  where
    basicLayout = smartBorders $ fullscreenFocus $ Tall 1 (3/100) (1/2)
    tallLayout  = avoidStruts $ basicLayout
    wideLayout  = avoidStruts $ Mirror $ basicLayout
    fullLayout  = avoidStruts $ noBorders Full

main = do 
  spawn "xmobar"

  xmonad $ ewmh $ desktopConfig
    { terminal = "urxvt"
    , modMask = modm
    , focusFollowsMouse = False
    , normalBorderColor = "#37474f"
    , focusedBorderColor = "#06989A"
    , layoutHook = myLayout
    }
      where 
        modm = mod4Mask
