import XMonad
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.EwmhDesktops
main = do
xmproc <- spawnPipe "/usr/bin/xmobar /home/yy_yank/.xmobarrc"  -- .xmoabrrcのパスを記述しておく
xmonad defaultConfig
  {
    modMask = mod4Mask
  ,  handleEventHook = fullscreenEventHook
  }
