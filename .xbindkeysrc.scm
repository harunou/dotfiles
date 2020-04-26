;; ~/.xbindkeysrc.scm

(xbindkey '(XF86MonBrightnessUp) "xbacklight -inc 10")
(xbindkey '(XF86MonBrightnessDown) "[[ $(printf '%.0f\n' $(xbacklight)) -gt 11 ]] && xbacklight -dec 10")
