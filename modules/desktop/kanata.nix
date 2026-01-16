{ ... }:

{
    services.kanata = {
        enable = true;
        keyboards = {
            internalKeyboard = {
                devices = [
                    "dev/input/by-path/platform-i8042-serio-0-event-kbd"
                ];
                extraDefCfg = "process-unmapped-keys yes";
                config = ''
                    (defsrc
                        a s d f
                        j k l ;
                        caps
                    )

                    (defvar
                        tap-time 250
                        hold-time 250
                    )

                    (defalias
                        a-mod (tap-hold $tap-time $hold-time a lmet)
                        s-mod (tap-hold $tap-time $hold-time s lalt)
                        d-mod (tap-hold $tap-time $hold-time d lsft)
                        f-mod (tap-hold $tap-time $hold-time f lctl)
                        ;-mod (tap-hold $tap-time $hold-time ; rmet)
                        l-mod (tap-hold $tap-time $hold-time l ralt)
                        k-mod (tap-hold $tap-time $hold-time k rsft)
                        j-mod (tap-hold $tap-time $hold-time j rctl)
                        caps-mod esc
                    )

                    (deflayer base 
                        @a-mod @s-mod @d-mod @f-mod
                        @j-mod @k-mod @l-mod @;-mod
                        @caps-mod
                    )
                '';
            };
        };
    };
}
