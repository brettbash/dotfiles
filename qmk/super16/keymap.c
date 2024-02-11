/*
 * _atomic16
 * アトミック16
 * @brettbash
 */

#include QMK_KEYBOARD_H

enum custom_layers {
    _NAV,
    _RGB,
    _NAV_2,
    _NAV_3,
};

enum custom_keycodes {
    SCREEN,
    CUT,
    COPY,
    HIDE,
    VIDEO,
    SCN_LT,
    SCN_RT,
};

#define NAV_FORW LGUI(KC_RBRC)
#define NAV_BACK LGUI(KC_LBRC)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [_NAV] = LAYOUT_ortho_4x4(
    TG(_NAV_2),            LGUI(KC_BSPC),     KC_LGUI,       XXXXXXX,
    LT(_NAV_3, KC_ESC),    KC_SPC,            KC_MS_BTN2,    KC_MS_BTN1,
    LGUI(KC_W),            LGUI(KC_H),        SCN_LT,        SCN_RT,
    LT(_NAV_2, CUT),       LT(_RGB, COPY),    LGUI(KC_V),    KC_ENT
  ),

  [_NAV_2] = LAYOUT_ortho_4x4(
    _______,    XXXXXXX,              XXXXXXX,              XXXXXXX,
    XXXXXXX,    XXXXXXX,              XXXXXXX,              XXXXXXX,
    LCTL(KC_0), LCTL(KC_1),           LCTL(KC_2),           KC_BSPC,
    _______,    LGUI(LCTL(KC_1)),     LGUI(LCTL(KC_2)),     LGUI(LCTL(KC_3))
  ),

  [_NAV_3] = LAYOUT_ortho_4x4(
    _______,    SCREEN,        XXXXXXX,     XXXXXXX,
    _______,    LGUI(KC_R),    NAV_BACK,    NAV_FORW,
    XXXXXXX,    XXXXXXX,       XXXXXXX,     XXXXXXX,
    _______,    XXXXXXX,       XXXXXXX,     XXXXXXX
  ),

  [_RGB] = LAYOUT_ortho_4x4(
    RGB_TOG,   RGB_HUI,    RGB_SAI,    RGB_VAI,
    RGB_MOD,   RGB_HUD,    RGB_SAD,    RGB_VAD,
    RGB_SPD,   RGB_SPI,    KC_TRNS,    KC_TRNS,
    KC_TRNS,   KC_TRNS,    KC_TRNS,    QK_BOOT
  ),
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case SCREEN:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LSHIFT) SS_LCMD("4") SS_UP(X_LSHIFT));
            }
            return false;
            break;

        case HIDE:
            if (record->event.pressed) {
                // SEND_STRING(SS_LCMD("h"));
                SEND_STRING("gg");
            }
            return false;
            break;

        case CUT:
            if (record->event.pressed) {
                SEND_STRING(SS_LCMD("x"));
            }
            return false;
            break;

        case COPY:
            if (record->event.pressed) {
                SEND_STRING(SS_LCMD("c"));
            }
            return false;
            break;

        case VIDEO:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LSHIFT) SS_LCMD("2") SS_UP(X_LSHIFT));
            }
            return false;
            break;

        /* Navigation */
        case SCN_LT:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LSHIFT) SS_DOWN(X_LALT) SS_LCTRL("7") SS_UP(X_LALT) SS_UP(X_LSHIFT));
            }
            return false;
            break;

        case SCN_RT:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LSHIFT) SS_DOWN(X_LALT) SS_LCTRL("8") SS_UP(X_LALT) SS_UP(X_LSHIFT));
            }
            return false;
            break;

    }
    return true;
}

bool encoder_update_user(uint8_t index, bool clockwise) {
    if (index == 0) { /* First encoder */
        if (clockwise) {
            tap_code_delay(KC_MS_WH_RIGHT, 10);
        } else {
            tap_code_delay(KC_MS_WH_LEFT, 10);
        }
    } else if (index == 1) { /* Second encoder */
        if (clockwise) {
            tap_code_delay(KC_MS_WH_DOWN, 10);
        } else {
            tap_code_delay(KC_MS_WH_UP, 10);
        }
    }
    return false;
}
