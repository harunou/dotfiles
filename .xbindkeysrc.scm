;; ~/.xbindkeysrc.scm

;; /usr/include/X11/keysymdef.h
;; /usr/include/X11/XF86keysym.h

(define mod
  (string->symbol (or (getenv "XBINDKEYS_MOD") "mod4")))

(xbindkey '(XF86MonBrightnessUp) "xbacklight -inc 10")
(xbindkey '(XF86MonBrightnessDown) "[[ $(printf '%.0f\n' $(xbacklight)) -gt 20 ]] && xbacklight -dec 10")

(xbindkey '(XF86AudioMute) "harunou media sink toggle")
(xbindkey '(XF86AudioLowerVolume) "harunou media sink -5%")
(xbindkey '(mod4 minus) "harunou media sink -5%")
(xbindkey '(XF86AudioRaiseVolume) "harunou media sink +5%")
(xbindkey '(mod4 plus) "harunou media sink +5%")
(xbindkey '(mod4 shift equal) "harunou media sink 100%")

(xbindkey '(XF86AudioMicMute) "harunou media source toggle")
(xbindkey '(mod1 XF86AudioMute) "harunou media source toggle")
(xbindkey '(mod1 XF86AudioLowerVolume) "harunou media source -5%")
(xbindkey '(mod1 minus) "harunou media source -5%")
(xbindkey '(mod1 XF86AudioRaiseVolume) "harunou media source +5%")
(xbindkey '(mod1 plus) "harunou media source +5%")
(xbindkey '(mod1 shift equal) "harunou media source 100%")

