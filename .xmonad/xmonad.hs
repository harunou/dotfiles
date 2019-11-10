import XMonad

main = xmonad def
    { terminal = "urxvt"
    , modMask = modm
--    , focusedBorderColor = "#000000"

    }
    where modm = mod4Mask
