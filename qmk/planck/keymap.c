/*
 * the._A C I D W R A I T H_
 * アシッドレイス
 * A Custom Planck Layout for Quantum Cyber Programming & Time Hacking
 * @brettbash
 */

#include QMK_KEYBOARD_H
#include "muse.h"

enum planck_layers {
    _COLEMAK,
    _LOWER,
    _VIM,
    _VMUX,
    _DOT_VIM,
    _ENTER,
    _FNC,
    _ESCAPE_ZONE,
    _DESIGN,
    _EMOJI,
    _SIZE_ONE,
    _PLAY_SIZE,
    _SUMMON,
    _NAV,
    _NAV_TEMP,
    _RAISE,
    _ADJUST,
    _WINDOW
};

enum planck_keycodes {
    COLEMAK = SAFE_RANGE,

    // Macros
    DESN_TOG,
    DEV_TOOLS,
    SRC_CODE,
    ONEPASSAPP,
    ONEPASS,
    COLRPIK,
    COLRSWT,
    PIXEL_SNAP,
    SCREEN,
    VIDEO,
    SCROLLSHOT,
    FULLSCNSHOT,
    C_SBAR,
    C_EXPLR,
    C_XTNS,
    C_SRCH,

    // VIM
    JUMP_TOP,
    OIL,
    OIL_ROOT,
    TMUX,
    TMUX_SESS,
    TMUX_MENU,
    T_LEFT,
    T_DOWN,
    T_UP,
    T_RIGHT,
    T_W0,
    T_W1,
    T_W2,
    T_W3,
    T_W4,
    T_W5,
    T_W6,
    T_W7,
    T_W8,
    T_RELOAD,
    T_SAVE,
    BUFF_NEXT,
    BUFF_PREV,
    BUFF_PICK,
    BUFF_CLOSE,
    BUFF_SORT_DIR,
    BUFF_SORT_TABS,
    BUFF_SORT_EXT,
    TASK_ADD,
    TAB_PREV,
    TAB_NEXT,
    TAB_NEW,
    TAB_CLOSE,
    TAB_RENAME,
    TAB_FIRST,
    TAB_LAST,
    RENAME,
    DELETE,
    DUPLICATE,
    S_R,
    V_SPLIT_X,
    V_SPLIT_Y,
    T_SPLIT_X,
    T_SPLIT_Y,
    SURR_R,
    SURR_LEFT,
    SURR_RIGHT,
    SURR_D,
    SURR_A,
    NOTICE,
    GLOW,
    RAIN,

    SCN_LT,
    SCN_RT,
    MCRL_OPN,
    MCRL_CLS,

    // Emoji
    KISS
};

#define LOWER MO(_LOWER)
#define RAISE MO(_RAISE)
#define KC_TABR LGUI(KC_RBRC)  // Send Command + ]
#define KC_TABL LGUI(KC_LBRC)  // Send Command + [
#define SPACE_FN LT(_NAV_TEMP, KC_SPC)
#define BSPC_VIM LT(_VIM, KC_BSPC)
#define EMOJI_ESC LT(_EMOJI, KC_ESC)
// #define QUEST LT(_ESCAPE_ZONE, LSFT(KC_SLSH)) // Hold down ? for a layer
#define ESCAPE LT(_ESCAPE_ZONE, KC_ESC)

#ifdef AUDIO_ENABLE
    float plover_song[][2]    = SONG(OVERWATCH);
    float caps_lock_on[][2]   = SONG(MUSHROOM);
    float caps_lock_off[][2]  = SONG(ONE_UP);
    float mission_open[][2]   = SONG(SONIC_RINGS);
    float mission_close[][2]  = SONG(COIN);
    float function_song[][2]  = SONG(ZELDA_1);
    float design_song[][2]    = SONG(MARIO);
    float plover_gb_song[][2] = SONG(GAMEOVER);
#endif

//
// Tap-Dance
// ----------------------------//
enum {
    TD_SFT_CAPS = 0,
    TD_SUMMON,
    TD_PLAY_SIZE
};

// Summon
void summon_start(qk_tap_dance_state_t *state, void *user_data) {
    if (state->count == 1) {
        // Single Tap
        if (!state->pressed) {
            if (layer_state_is(_NAV)) {
                layer_off(_NAV);
            } else {
                layer_on(_NAV);
            }
        // Hold
        } else {
            layer_on(_SUMMON);
        }
    } else {
        // Double-Tap
    }
}

void summon_reset(qk_tap_dance_state_t *state, void *user_data) {
    // If the key was held down and now is released then switch off the layer
    if (state->count == 1 && !state->pressed) {
        layer_off(_SUMMON);
    }
}

// Play Size
// Window Sizing available in the Play button when held
void play_start(qk_tap_dance_state_t *state, void *user_data) {
    if (state->count == 1) {
        // Single Tap
        if (!state->pressed) {
            register_code16(KC_LSFT);
            register_code16(KC_LALT);
            register_code16(KC_9);
        // Hold
        } else {
            layer_on(_PLAY_SIZE);
        }
    } else {
        // Double-Tap
    }
}

void play_reset(qk_tap_dance_state_t *state, void *user_data) {
    if (state->count == 1) {
        // If the key was held down and now is released then switch off the layer
        if (!state->pressed) {
            unregister_code16(KC_LSFT);
            unregister_code16(KC_LALT);
            unregister_code16(KC_9);
            layer_off(_PLAY_SIZE);
        }
    }
}

// Toggle Caps
float caps_active = 0;
void toggle_caps(qk_tap_dance_state_t *state, void *user_data) {
    if (state->count == 1) {
        register_code16(KC_LSFT);
    } else {
        if (caps_active == 0) {
            register_code16(KC_CAPSLOCK);
            PLAY_SONG(caps_lock_on);
            caps_active = 1;
        } else if (caps_active == 1) {
            unregister_code16(KC_CAPSLOCK);
            register_code16(KC_CAPSLOCK);
            unregister_code16(KC_CAPSLOCK);
            PLAY_SONG(caps_lock_off);
            caps_active = 0;
        }
    }
}

void reset_caps(qk_tap_dance_state_t *state, void *user_data) {
    if (state->count == 1) {
        unregister_code16(KC_LSFT);
    }
}

// Register Tap Dance Actions
qk_tap_dance_action_t tap_dance_actions[] = {
    [TD_SUMMON]  = ACTION_TAP_DANCE_FN_ADVANCED(NULL, summon_start, summon_reset),
    [TD_PLAY_SIZE]  = ACTION_TAP_DANCE_FN_ADVANCED(NULL, play_start, play_reset),
    [TD_SFT_CAPS]  = ACTION_TAP_DANCE_FN_ADVANCED(NULL, toggle_caps, reset_caps),
};

// Set a long-ish tapping term for tap-dance keys
uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case QK_TAP_DANCE ... QK_TAP_DANCE_MAX:
            return 275;
        default:
            return TAPPING_TERM;
    }
}

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

// π ----
// :: COLEMAK ---------------------------::
// ____
[_COLEMAK] = LAYOUT_planck_grid(
    KC_TAB,          KC_Q,    KC_W,    KC_F,    KC_P,  KC_B,     KC_J,     KC_L,  KC_U,     KC_Y,        KC_SCLN,       TD(TD_SUMMON),
    ESCAPE,          KC_A,    KC_R,    KC_S,    KC_T,  KC_G,     KC_M,     KC_N,  KC_E,     KC_I,        KC_O,          KC_QUOT,
    TD(TD_SFT_CAPS), KC_Z,    KC_X,    KC_C,    KC_D,  KC_V,     KC_K,     KC_H,  LT(_VMUX, KC_COMM),    LT(_DOT_VIM,   KC_DOT), KC_SLSH, LT(_ENTER, KC_ENT),
    KC_MPLY,         KC_LCTL, KC_LALT, KC_LGUI, LOWER, BSPC_VIM, SPACE_FN, RAISE, MO(_FNC), MO(_DESIGN), MO(_SIZE_ONE), TD(TD_PLAY_SIZE)
),

// π ----
// :: LOWER ---------------------------::
// ____
[_LOWER] = LAYOUT_planck_grid(
    KC_GRV,  KC_EXLM, KC_AT,            KC_HASH,       KC_DLR,  KC_PERC, KC_CIRC, KC_AMPR, KC_ASTR,    KC_PIPE,          LSFT(KC_SCLN),           KC_EQL,
    KC_TILD, KC_BSLS, KC_LCBR,          KC_LBRC,       KC_LPRN, KC_LT,   KC_GT,   KC_RPRN, KC_RBRC,    KC_RCBR,          KC_SLSH,                 KC_PLUS,
    _______, _______, LALT(LSFT(KC_A)), LGUI(KC_SLSH), KC_TABL, KC_MINS, KC_UNDS, KC_TABR, LGUI(KC_P), LGUI(LSFT(KC_P)), LGUI(KC_E),              KC_ENT,
    _______, _______, _______,          _______,       _______, _______, KC_SPC,  _______, XXXXXXX,    XXXXXXX,          LALT(LSFT(KC__VOLDOWN)), LALT(LSFT(KC__VOLUP))
),

// π ----
// :: RAISE ---------------------------::
// ____
[_RAISE] = LAYOUT_planck_grid(
    LCTL(KC_2), LGUI(LCTL(KC_1)), LGUI(LCTL(KC_2)), LGUI(LCTL(KC_3)), _______, KC_5,    KC_6,   KC_7,    KC_8, KC_9,    KC_0,    LSFT(KC_SCLN),
    LCTL(KC_1), KC_F1,            KC_F2,            KC_F3,            KC_F4,   KC_F5,   KC_F6,  KC_4,    KC_5, KC_6,    KC_SLSH, KC_PPLS,
    LCTL(KC_0), KC_F7,            KC_F8,            KC_F9,            KC_F10,  KC_F11,  KC_F12, KC_1,    KC_2, KC_3,    KC_ASTR, KC_MINS,
    _______,    _______,          _______,          _______,          _______, KC_BSPC, KC_SPC, _______, KC_0, KC_PDOT, KC_EQL,  KC_ENT
),

[_WINDOW] = LAYOUT_planck_grid(
    LCTL(KC_2), LGUI(LCTL(KC_1)), LGUI(LCTL(KC_2)), LGUI(LCTL(KC_3)), _______, _______, _______, _______, _______, _______, _______, _______,
    LCTL(KC_1), _______,          _______,          _______,          _______, _______, _______, _______, _______, _______, _______, _______,
    LCTL(KC_0), _______,          _______,          _______,          _______, _______, _______, _______, _______, _______, _______, _______,
    _______,    _______,          _______,          _______,          _______, _______, _______, _______, _______, _______, _______, _______
),

// π ----
// :: VIM ---------------------------::
// ____
[_VIM] = LAYOUT_planck_grid(
    _______, _______, LSFT(KC_G), JUMP_TOP, _______, _______, KC_CIRC, LCTL(KC_F),         LCTL(KC_D),       LCTL(KC_U), LCTL(KC_B), _______,
    KC_ESC,  KC_B,    KC_RCBR,    KC_LCBR,  KC_W,    KC_E,    KC_0,    KC_H,               KC_J,             KC_K,             KC_L,  KC_DLR,
    _______, KC_F1,   KC_F2,      KC_F3,    KC_F4,   _______, _______, S_R,                OIL,              OIL_ROOT,      _______, _______,
    _______, _______, _______,    _______,  _______, _______, KC_LSFT, LGUI(LSFT(KC_SPC)), LGUI(LSFT(KC_J)), _______,       _______, _______
),

[_VMUX] = LAYOUT_planck_grid(
    XXXXXXX, T_SPLIT_X,  T_SPLIT_Y,  V_SPLIT_X,  V_SPLIT_Y,  XXXXXXX, XXXXXXX, XXXXXXX,    XXXXXXX, XXXXXXX, XXXXXXX,    XXXXXXX,
    XXXXXXX, LCTL(KC_H), LCTL(KC_J), LCTL(KC_K), LCTL(KC_L), XXXXXXX, XXXXXXX, LALT(KC_B), XXXXXXX, XXXXXXX, LALT(KC_N), XXXXXXX,
    SURR_R,  SURR_LEFT,  SURR_D,     SURR_A,     SURR_RIGHT, NOTICE,  GLOW,    TMUX_SESS,  XXXXXXX, TMUX,    TMUX_MENU,  RAIN,
    XXXXXXX, XXXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXXX, XXXXXXX, XXXXXXX,    XXXXXXX, XXXXXXX, XXXXXXX,    XXXXXXX
),

[_DOT_VIM] = LAYOUT_planck_grid(
    XXXXXXX, XXXXXXX,   BUFF_SORT_EXT, BUFF_SORT_TABS, BUFF_SORT_DIR, XXXXXXX, XXXXXXX, XXXXXXX,   XXXXXXX,    XXXXXXX, XXXXXXX,   XXXXXXX,
    XXXXXXX, BUFF_PREV, LALT(KC_J),    LALT(KC_K),     BUFF_NEXT,     XXXXXXX, XXXXXXX, XXXXXXX,   XXXXXXX,    XXXXXXX, XXXXXXX,   XXXXXXX,
    XXXXXXX, TASK_ADD,  BUFF_CLOSE,    BUFF_PICK,      XXXXXXX,       XXXXXXX, XXXXXXX, TAB_PREV,  TAB_NEXT,   XXXXXXX, TAB_NEW,   TAB_CLOSE,
    XXXXXXX, XXXXXXX,   XXXXXXX,       XXXXXXX,        XXXXXXX,       DELETE,  RENAME,  DUPLICATE, TAB_RENAME, XXXXXXX, TAB_FIRST, TAB_LAST
),

[_ENTER] = LAYOUT_planck_grid(
    XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
    XXXXXXX, T_W0,     T_W1,    T_W2,    T_W3,    T_W4,    T_W5,    T_LEFT,  T_DOWN,  T_UP,    T_RIGHT, XXXXXXX,
    XXXXXXX, T_W6,     T_W7,    T_W8,    XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
    XXXXXXX, T_RELOAD, T_SAVE,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX
),

// π ----
// :: NAVIGATION ---------------------------::
// ____
[_NAV_TEMP] = LAYOUT_planck_grid(
    _______, KC_MS_WH_LEFT, KC_MS_WH_UP, KC_MS_WH_DOWN, KC_MS_WH_RIGHT, KC_MS_BTN2,   LGUI(KC_R),   KC_MS_BTN1, KC_MS_BTN2, KC_MS_BTN3, LGUI(KC_H), KC_BSPC,
    KC_ESC,  KC_MS_LEFT,    KC_MS_DOWN,  KC_MS_UP,      KC_MS_RIGHT,    KC_MS_BTN1,   LGUI(KC_T),   KC_LEFT,    KC_DOWN,    KC_UP,      KC_RGHT,    LGUI(KC_W),
    _______, LGUI(KC_A),    LGUI(KC_X),  LGUI(KC_C),    LGUI(KC_D),     LGUI(KC_V),   LGUI(KC_GRV), SCN_LT,     SCN_RT,     MCRL_OPN,   MCRL_CLS,   _______,
    _______, _______,       _______,     _______,       _______,        LGUI(KC_SPC), _______,      _______,    _______,    _______,    _______,    _______
),

[_NAV] = LAYOUT_planck_grid(
    _______, KC_MS_WH_LEFT, KC_MS_WH_UP, KC_MS_WH_DOWN, KC_MS_WH_RIGHT, KC_MS_BTN2, LGUI(KC_R),   KC_MS_BTN1,  KC_MS_BTN2, KC_MS_BTN3, LGUI(KC_H), _______,
    KC_ESC,  KC_MS_LEFT,    KC_MS_DOWN,  KC_MS_UP,      KC_MS_RIGHT,    KC_MS_BTN1, LGUI(KC_T),   KC_LEFT,     KC_DOWN,    KC_UP,      KC_RGHT,    LGUI(KC_W),
    _______, LGUI(KC_A),    LGUI(KC_X),  LGUI(KC_C),    LGUI(KC_D),     LGUI(KC_V), LGUI(KC_GRV), SCN_LT,      SCN_RT,     MCRL_OPN,   MCRL_CLS,   _______,
    _______, _______,       _______,     _______,       _______,        _______,    _______,      MO(_WINDOW), _______,    _______,    _______,    _______
),

// π ----
// :: MACROS ---------------------------::
// ____
[_FNC] = LAYOUT_planck_grid(
    SRC_CODE,               LGUI(LALT(LCTL(LSFT(KC_8)))),  LGUI(LALT(LCTL(LSFT(KC_9)))),  LGUI(LALT(LCTL(LSFT(KC_0)))), LGUI(LALT(LCTL(LSFT(KC_A)))), LGUI(LALT(LCTL(LSFT(KC_C)))),  LGUI(LALT(LCTL(LSFT(KC_D)))), LGUI(LALT(LCTL(LSFT(KC_E)))), LGUI(LALT(LCTL(LSFT(KC_F)))), LGUI(LALT(LCTL(LSFT(KC_G)))), LGUI(LALT(LCTL(LSFT(KC_H)))), LGUI(LALT(LCTL(LSFT(KC_F4)))),
    DEV_TOOLS,              LGUI(LALT(LCTL(LSFT(KC_1)))),  LGUI(LALT(LCTL(LSFT(KC_2)))),  LGUI(LALT(LCTL(LSFT(KC_I)))), ONEPASSAPP,                   LGUI(LALT(LCTL(LSFT(KC_J)))),  LGUI(LALT(LCTL(LSFT(KC_3)))), LGUI(LALT(LCTL(LSFT(KC_4)))), LGUI(LALT(LCTL(LSFT(KC_5)))), LGUI(LALT(LCTL(LSFT(KC_6)))), LGUI(LALT(LCTL(LSFT(KC_7)))), LGUI(LALT(LCTL(LSFT(KC_F5)))),
    LGUI(LALT(LSFT(KC_A))), LGUI(LALT(LCTL(LSFT(KC_F6)))), LGUI(LALT(LCTL(LSFT(KC_F7)))), LGUI(LALT(LCTL(KC_F14))),     ONEPASS,                      LGUI(LALT(LCTL(LSFT(KC_F9)))), LGUI(LALT(LCTL(LSFT(KC_L)))), LGUI(LALT(LCTL(LSFT(KC_M)))), LGUI(LALT(LCTL(LSFT(KC_N)))), LALT(LSFT(KC_8)),             LGUI(LALT(LCTL(LSFT(KC_P)))), LGUI(LALT(LCTL(LSFT(KC_F8)))),
    _______,                SCREEN,                        VIDEO,                         SCROLLSHOT,                   FULLSCNSHOT,                  LGUI(LALT(LSFT(KC_B))),        LGUI(LALT(LCTL(LSFT(KC_S)))), LGUI(LALT(LCTL(LSFT(KC_R)))), XXXXXXX,                      KC_MUTE,                      KC_MRWD,                      KC_MFFD
),

[_ESCAPE_ZONE] = LAYOUT_planck_grid(
KC_LCTL,                      KC_TAB,                       XXXXXXX,                       XXXXXXX,                       XXXXXXX,                       _______, _______, LGUI(LCTL(LALT(KC_1))), LGUI(LCTL(LALT(KC_2))), LGUI(LCTL(LALT(KC_3))), LGUI(LCTL(LALT(KC_4))), _______,
XXXXXXX,                      XXXXXXX,                      XXXXXXX,                       XXXXXXX,                       _______,                       _______, _______, _______,                LGUI(LSFT(KC_RBRC)),    LGUI(LSFT(KC_LBRC)),    _______,                _______,
LGUI(LALT(LCTL(LSFT(KC_K)))), LGUI(LALT(LCTL(LSFT(KC_B)))), LGUI(LALT(LCTL(LSFT(KC_F1)))), LGUI(LALT(LCTL(LSFT(KC_F2)))), LGUI(LALT(LCTL(LSFT(KC_F3)))), _______, _______, _______,                _______,                _______,                _______,                _______,
_______,                      _______,                      _______,                       _______,                       _______,                       _______, _______, _______,                _______,                _______,                _______,                _______
),

// π ----
// :: SUMMON ---------------------------::
// ____
[_SUMMON] = LAYOUT_planck_grid(
        LGUI(LALT(LCTL(KC_F4))), LGUI(LALT(LCTL(KC_Q))),   LGUI(LALT(LCTL(KC_W))), LGUI(LALT(LCTL(KC_F))),   LGUI(LALT(LCTL(KC_P))),  LGUI(LALT(LCTL(KC_B))),  LGUI(LALT(LCTL(KC_J))),  LGUI(LALT(LCTL(KC_L))),  LGUI(LALT(LCTL(KC_U))),  LGUI(LALT(LCTL(KC_Y))),   LGUI(KC_H),               _______,
        LGUI(LALT(LCTL(KC_F2))), LGUI(LALT(LCTL(KC_A))),   LGUI(LALT(LCTL(KC_R))), LGUI(LALT(LCTL(KC_S))),   LGUI(LALT(LCTL(KC_T))),  LGUI(LALT(LCTL(KC_G))),  LGUI(LALT(LCTL(KC_M))),  LGUI(LALT(LCTL(KC_N))),  LGUI(LALT(LCTL(KC_E))),  LGUI(LALT(LCTL(KC_I))),   LGUI(LALT(LCTL(KC_O))),   LGUI(LALT(LCTL(KC_Z))),
        LGUI(LALT(LCTL(KC_H))),  LGUI(LALT(LCTL(KC_F3))),  LGUI(LALT(LCTL(KC_X))), LGUI(LALT(LCTL(KC_C))),   LGUI(LALT(LCTL(KC_F5))), LGUI(LALT(LCTL(KC_F6))), LGUI(LALT(LCTL(KC_F7))), LGUI(LALT(LCTL(KC_F8))), LGUI(LALT(LCTL(KC_F9))), LGUI(LALT(LCTL(KC_F10))), LGUI(LALT(LCTL(KC_F13))), XXXXXXX,
        _______,                 LGUI(LALT(LCTL(KC_F12))), LGUI(LALT(LCTL(KC_V))), LGUI(LALT(LCTL(KC_F11))), LGUI(LALT(LCTL(KC_K))),  LGUI(LALT(LCTL(KC_D))),  XXXXXXX,                 XXXXXXX,                 XXXXXXX,                 XXXXXXX,                  XXXXXXX,                  LGUI(LALT(LCTL(KC_F1)))
),

// π ----
// :: WINDOW SIZING & MANAGEMENT ---------------------------::
// ____
[_SIZE_ONE] = LAYOUT_planck_grid(
    LGUI(LALT(LCTL(KC_BSLS))), LGUI(LALT(KC_DOT)), LGUI(LALT(KC_SLSH)), LGUI(LALT(LCTL(KC_LEFT))), LGUI(LALT(LCTL(KC_RGHT))), LGUI(LALT(KC_Q)), LGUI(LALT(KC_W)), LGUI(LALT(KC_F)), LGUI(LALT(KC_SCLN)), LGUI(LALT(KC_COMM)), LGUI(LALT(KC_A)), LGUI(LALT(KC_R)),
    LGUI(LALT(KC_2)),          LGUI(LALT(KC_1)),   LGUI(LALT(KC_4)),    LGUI(LALT(KC_5)),          LGUI(LALT(KC_6)),          LGUI(LALT(KC_P)), LGUI(LALT(KC_B)), LGUI(LALT(KC_J)), LGUI(LALT(KC_S)),    LGUI(LALT(KC_T)),    LGUI(LALT(KC_G)), LGUI(LALT(KC_M)),
    LGUI(LALT(KC_7)),          LGUI(LALT(KC_8)),   LGUI(LALT(KC_9)),    LGUI(LALT(KC_MINS)),       XXXXXXX,                   LGUI(LALT(KC_L)), LGUI(LALT(KC_U)), LGUI(LALT(KC_Y)), LGUI(LALT(KC_N)),    LGUI(LALT(KC_E)),    LGUI(LALT(KC_I)), LGUI(LALT(KC_O)),
    _______,                   LGUI(LALT(KC_3)),   LGUI(LALT(KC_0)),    _______,                   _______,                   _______,          _______,          _______,          _______,             _______,             _______,          LGUI(LALT(LCTL(KC_F20)))
),

[_PLAY_SIZE] = LAYOUT_planck_grid(
    LGUI(LALT(KC_Z)),   LGUI(LALT(KC_X)),   LGUI(LALT(KC_C)),    LGUI(LALT(KC_F9)), LGUI(LALT(KC_F8)), LGUI(LALT(KC_F7)), LGUI(LALT(KC_F13)), LGUI(LALT(KC_F14)), LGUI(LALT(KC_F15)),       XXXXXXX, XXXXXXX, XXXXXXX,
    LGUI(LALT(KC_K)),   LGUI(LALT(KC_H)),   LGUI(LALT(KC_COMM)), LGUI(LALT(KC_F6)), LGUI(LALT(KC_F5)), LGUI(LALT(KC_F4)), LGUI(LALT(KC_F16)), LGUI(LALT(KC_F17)), LGUI(LALT(KC_F18)),       XXXXXXX, XXXXXXX, XXXXXXX,
    LGUI(LALT(KC_F12)), LGUI(LALT(KC_F11)), LGUI(LALT(KC_F10)),  LGUI(LALT(KC_F3)), LGUI(LALT(KC_F2)), LGUI(LALT(KC_F1)), LGUI(LALT(KC_F19)), LGUI(LALT(KC_F20)), LGUI(LALT(LSFT(KC_F20))), XXXXXXX, XXXXXXX, XXXXXXX,
    _______,            LGUI(LALT(KC_3)),   LGUI(LALT(KC_0)),    XXXXXXX,           XXXXXXX,           XXXXXXX,           XXXXXXX,            XXXXXXX,            XXXXXXX,                  XXXXXXX, XXXXXXX, LGUI(LALT(LCTL(KC_G)))
),


// π ----
// :: DESIGN ---------------------------::
// ____
[_DESIGN] = LAYOUT_planck_grid(
    KC_F,    KC_V,       KC_R,       KC_O,       KC_P,       KC_T,             KC_B,             LALT(KC_A),       LALT(KC_H), LALT(KC_D), LGUI(LALT(KC_K)), _______,
    _______, KC_EXLM,    KC_I,       KC_L,       LGUI(KC_G), LGUI(LSFT(KC_G)), LGUI(LSFT(KC_K)), LALT(KC_W),       LALT(KC_V), LALT(KC_S), LGUI(LSFT(KC_O)), _______,
    _______, LGUI(KC_0), LGUI(KC_X), LGUI(KC_C), LGUI(KC_D), LGUI(KC_V),       LGUI(KC_Z),       LGUI(LSFT(KC_Z)), LCTL(KC_G), LSFT(KC_R), LGUI(LALT(KC_M)), _______,
    _______, _______,    _______,    _______,    _______,    _______,          _______,          _______,          _______,    _______,    _______,          _______
),

// Emoji
[_EMOJI] = LAYOUT_planck_grid(
    XXXXXXX, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
    XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, _______, _______, _______, _______, _______, _______, _______, _______,
    _______, XXXXXXX, XXXXXXX, _______, _______, _______, _______, _______, _______, _______, _______, _______,
    _______, XXXXXXX, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______
),
/* [_EMOJI] = LAYOUT_planck_grid(
    _______, CRY,     SHOCK,   SAD,     THUMBDN, HEART,     SSMILE,  THUMBUP, METAL,   OK,      MUSCLE,  ALIEN,
    _______, _______, _______, _______, _______, HEARTEYES, KISS,    SMILE,   PRAISE,  LMAO,    ROFL,    VULCAN,
    _______, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______,
    _______, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______
), */


// [_ENTER] = LAYOUT_planck_grid(
//     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
//     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
//     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
//     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX
// ),


/* Adjust (Lower + Raise)
 *                      v------------------------RGB CONTROL--------------------v
 * ,-----------------------------------------------------------------------------------.
 * |      | Reset|Debug | RGB  |RGBMOD| HUE+ | HUE- | SAT+ | SAT- |BRGTH+|BRGTH-|  Del |
 * |------+------+------+------+------+------+------+------+------+------+------+------|
 * |      |      |MUSmod|Aud on|Audoff|AGnorm|AGswap|      |Colemk|      |      |      |
 * |------+------+------+------+------+------+------+------+------+------+------+------|
 * |      |Voice-|Voice+|Mus on|Musoff|MIDIon|MIDIof|TermOn|TermOf|      |      |      |
 * |------+------+------+------+------+------+------+------+------+------+------+------|
 * |      |      |      |      |      |             |      |      |      |      |      |
 * `-----------------------------------------------------------------------------------'
 */
[_ADJUST] = LAYOUT_planck_grid(
    _______, RESET,   DEBUG,   RGB_TOG, RGB_MOD, RGB_HUI, RGB_HUD, RGB_SAI, RGB_SAD,  RGB_VAI, RGB_VAD, KC_DEL,
    _______, _______, MU_MOD,  AU_ON,   AU_OFF,  AG_NORM, AG_SWAP, _______, COLEMAK,  _______, _______, _______,
    _______, MUV_DE,  MUV_IN,  MU_ON,   MU_OFF,  MI_ON,   MI_OFF,  _______, _______, _______, _______, _______,
    _______, _______, _______, _______, _______, _______, _______, _______, _______,  _______, _______, _______
)
};


layer_state_t layer_state_set_user(layer_state_t state) {
    switch (biton32(state)) {
        case _COLEMAK:
            autoshift_enable();
            break;
        case _DESIGN:
            autoshift_disable();
            PLAY_SONG(design_song);
            break;
        case _FNC:
            autoshift_disable();
            PLAY_SONG(function_song);
            break;
        default:
            autoshift_disable();
            break;
        }
    return update_tri_layer_state(state, _LOWER, _RAISE, _ADJUST);
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case COLEMAK:
        if (record->event.pressed) {
            set_single_persistent_default_layer(_COLEMAK);
        }
        return false;
        break;

        /* Macros */
        case DEV_TOOLS:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LCTRL) SS_LCMD("i") SS_UP(X_LCTRL));
            }
            return false;
            break;

        case SRC_CODE:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LCTRL) SS_LCMD("u") SS_UP(X_LCTRL));
            }
            return false;
            break;

        case ONEPASSAPP:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LCTRL) SS_LCMD("/") SS_UP(X_LCTRL));
            }
            return false;
            break;

        case ONEPASS:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LCTRL) SS_LCMD("g") SS_UP(X_LCTRL));
            }
            return false;
            break;

        case COLRPIK:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LCTRL) SS_DOWN(X_LALT) SS_LCMD("x") SS_UP(X_LCTRL) SS_UP(X_LALT));
            }
            return false;
            break;

        case COLRSWT:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LCTRL) SS_DOWN(X_LALT) SS_LCMD("d") SS_UP(X_LCTRL) SS_UP(X_LALT));
            }
            return false;
            break;

        case PIXEL_SNAP:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LALT) SS_LCTRL("f") SS_UP(X_LALT));
            }
            return false;
            break;

        case SCREEN:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LSHIFT) SS_LCMD("4") SS_UP(X_LSHIFT));
            }
            return false;
            break;

        case VIDEO:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LSHIFT) SS_LCMD("2") SS_UP(X_LSHIFT));
            }
            return false;
            break;

        case SCROLLSHOT:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LSHIFT) SS_LCMD("6") SS_UP(X_LSHIFT));
            }
            return false;
            break;

        case FULLSCNSHOT:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LSHIFT) SS_LCMD("3") SS_UP(X_LSHIFT));
            }
            return false;
            break;

        case C_SBAR:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LCTRL) SS_DOWN(X_TAB) SS_UP(X_TAB));
            }
            return false;
            break;

        /* VIM */
        case JUMP_TOP:
            if (record->event.pressed) {
                SEND_STRING("gg");
            }
            return false;
            break;

        case OIL:
            if (record->event.pressed) {
                SEND_STRING(" fm");
            }
            return false;
            break;

        case OIL_ROOT:
            if (record->event.pressed) {
                SEND_STRING(" fM");
            }
            return false;
            break;

        case TMUX:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a"));
            }
            return false;
            break;

        case TMUX_SESS:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") "t");
            }
            return false;
            break;

        case TMUX_MENU:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") "\\");
            }
            return false;
            break;

        case T_LEFT:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") SS_DOWN(X_LEFT) SS_UP(X_LEFT));
            }
            return false;
            break;

        case T_DOWN:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") SS_DOWN(X_DOWN) SS_UP(X_DOWN));
            }
            return false;
            break;

        case T_UP:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") SS_DOWN(X_UP) SS_UP(X_UP));
            }
            return false;
            break;

        case T_RIGHT:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") SS_DOWN(X_RIGHT) SS_UP(X_RIGHT));
            }
            return false;
            break;

        case T_W0:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") SS_DOWN(X_0) SS_UP(X_0));
            }
            return false;
            break;

        case T_W1:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") SS_DOWN(X_1) SS_UP(X_1));
            }
            return false;
            break;

        case T_W2:
            if (record->event.pressed) {
            SEND_STRING(SS_LCTRL("a") SS_DOWN(X_2) SS_UP(X_2));
            }
            return false;
            break;

        case T_W3:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") SS_DOWN(X_3) SS_UP(X_3));
            }
            return false;
            break;

        case T_W4:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") SS_DOWN(X_4) SS_UP(X_4));
            }
            return false;
            break;

        case T_W5:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") SS_DOWN(X_5) SS_UP(X_5));
            }
            return false;
            break;

        case T_W6:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") SS_DOWN(X_6) SS_UP(X_6));
            }
            return false;
            break;

        case T_W7:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") SS_DOWN(X_7) SS_UP(X_7));
            }
            return false;
            break;

        case T_W8:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") SS_DOWN(X_8) SS_UP(X_8));
            }
            return false;
            break;

        case T_RELOAD:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") SS_DOWN(X_R) SS_UP(X_R));
            }
            return false;
            break;

        case T_SAVE:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") SS_LCTL("s"));
            }
            return false;
            break;

        case TASK_ADD:
            if (record->event.pressed) {
                SEND_STRING("- [ ] ");
            }
            return false;
            break;

        case BUFF_PREV:
            if (record->event.pressed) {
                SEND_STRING(" bp");
            }
            return false;
            break;

        case BUFF_NEXT:
            if (record->event.pressed) {
                SEND_STRING(" bn");
            }
            return false;
            break;

        case BUFF_PICK:
            if (record->event.pressed) {
                SEND_STRING(" bo");
            }
            return false;
            break;

        case BUFF_CLOSE:
            if (record->event.pressed) {
                SEND_STRING(" bc");
            }
            return false;
            break;

        case BUFF_SORT_DIR:
            if (record->event.pressed) {
                SEND_STRING(" bsd");
            }
            return false;
            break;

        case BUFF_SORT_TABS:
            if (record->event.pressed) {
                SEND_STRING(" bst");
            }
            return false;
            break;

        case BUFF_SORT_EXT:
            if (record->event.pressed) {
                SEND_STRING(" bse");
            }
            return false;
            break;

        case TAB_PREV:
            if (record->event.pressed) {
                SEND_STRING(" " SS_DOWN(X_TAB) SS_UP(X_TAB) "[");
            }
            return false;
            break;

        case TAB_NEXT:
            if (record->event.pressed) {
                SEND_STRING(" " SS_DOWN(X_TAB) SS_UP(X_TAB) "]");
            }
            return false;
            break;

        case TAB_NEW:
            if (record->event.pressed) {
                SEND_STRING(" " SS_DOWN(X_TAB) SS_UP(X_TAB) SS_DOWN(X_TAB) SS_UP(X_TAB));
            }
            return false;
            break;

        case TAB_CLOSE:
            if (record->event.pressed) {
                SEND_STRING(" " SS_DOWN(X_TAB) SS_UP(X_TAB) "d");
            }
            return false;
            break;

        case TAB_RENAME:
            if (record->event.pressed) {
                SEND_STRING(":BufferLineTabRename ");
            }
            return false;
            break;

        case TAB_FIRST:
            if (record->event.pressed) {
                SEND_STRING(" " SS_DOWN(X_TAB) SS_UP(X_TAB) "f");
            }
            return false;
            break;

        case TAB_LAST:
            if (record->event.pressed) {
                SEND_STRING(" " SS_DOWN(X_TAB) SS_UP(X_TAB) "l");
            }
            return false;
            break;

        case RENAME:
            if (record->event.pressed) {
                SEND_STRING(":Rename ");
            }
            return false;
            break;

        case DELETE:
            if (record->event.pressed) {
                SEND_STRING(":Delete");
            }
            return false;
            break;

        case DUPLICATE:
            if (record->event.pressed) {
                SEND_STRING(":Duplicate ");
            }
            return false;
            break;

        case S_R:
            if (record->event.pressed) {
                SEND_STRING(":%s/");
            }
            return false;
            break;

        case V_SPLIT_X:
            if (record->event.pressed) {
                SEND_STRING(" -");
            }
            return false;
            break;

        case V_SPLIT_Y:
            if (record->event.pressed) {
                SEND_STRING(" |");
            }
            return false;
            break;

        case T_SPLIT_X:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") "-");
            }
            return false;
            break;

        case T_SPLIT_Y:
            if (record->event.pressed) {
                SEND_STRING(SS_LCTRL("a") "|");
            }
            return false;
            break;

        case SURR_R:
            if (record->event.pressed) {
                SEND_STRING("gsr");
            }
            return false;
            break;

        case SURR_LEFT:
            if (record->event.pressed) {
                SEND_STRING("gsF");
            }
            return false;
            break;

        case SURR_RIGHT:
            if (record->event.pressed) {
                SEND_STRING("gsf");
            }
            return false;
            break;

        case SURR_D:
            if (record->event.pressed) {
                SEND_STRING("gsd");
            }
            return false;
            break;

        case SURR_A:
            if (record->event.pressed) {
                SEND_STRING("gsa");
            }
            return false;
            break;

        case NOTICE:
            if (record->event.pressed) {
                SEND_STRING(" snh");
            }
            return false;
            break;

        case GLOW:
            if (record->event.pressed) {
                SEND_STRING(":Glow" SS_DOWN(X_ENT) SS_UP(X_ENT));
            }
            return false;
            break;

        case RAIN:
            if (record->event.pressed) {
                SEND_STRING(" Cr");
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

        // Mission Control Open
        case MCRL_OPN:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LCTRL) SS_DOWN(X_EQL) SS_UP(X_LCTRL) SS_UP(X_EQL));
                PLAY_SONG(mission_open);
            }
            return false;
            break;

        // Mission Control Close
        case MCRL_CLS:
            if (record->event.pressed) {
                SEND_STRING(SS_DOWN(X_LCTRL) SS_DOWN(X_LALT) SS_DOWN(X_EQL) SS_UP(X_LCTRL) SS_UP(X_LALT) SS_UP(X_EQL));
                PLAY_SONG(mission_close);
            }
            return false;
            break;

        // Emoji
        case KISS:
            if (record->event.pressed) {
                SEND_STRING(SS_LALT("D83D+DE18"));
            }
            return false;
            break;
    }
    return true;
}

bool muse_mode = false;
uint8_t last_muse_note = 0;
uint16_t muse_counter = 0;
uint8_t muse_offset = 70;
uint16_t muse_tempo = 50;

bool encoder_update_user(uint8_t index, bool clockwise) {
    if (IS_LAYER_ON(_DESIGN)) {
        if (clockwise) {
            tap_code16(LGUI(KC_MINS));
        } else {
            tap_code16(LGUI(KC_EQL));
        }
    } else if (IS_LAYER_ON(_FNC)) {
        if (clockwise) {
            tap_code16(A(S(KC__VOLDOWN)));
        } else {
            tap_code16(A(S(KC__VOLUP)));
        }
    } else if (IS_LAYER_ON(_RAISE)) {
        if (clockwise) {
            tap_code16(KC_F9);
        } else {
            tap_code16(KC_F10);
        }
    } else if (IS_LAYER_ON(_NAV_TEMP)) {
        if (clockwise) {
            tap_code16(KC_F11);
        } else {
            tap_code16(KC_F12);
        }
    } else {
        if (clockwise) {
            tap_code16(LGUI(LALT(KC_DOWN)));
        } else {
            tap_code16(LGUI(LALT(KC_UP)));
        }
    }
    return false;
}

bool dip_switch_update_user(uint8_t index, bool active) {
    switch (index) {
        case 0: {
#ifdef AUDIO_ENABLE
    static bool play_sound = false;
#endif
    if (active) {
#ifdef AUDIO_ENABLE
    if (play_sound) { PLAY_SONG(plover_song); }
#endif
        layer_on(_ADJUST);
    } else {
#ifdef AUDIO_ENABLE
    if (play_sound) { PLAY_SONG(plover_gb_song); }
#endif
        layer_off(_ADJUST);
    }
#ifdef AUDIO_ENABLE
    play_sound = true;
#endif
        break;
    }
    case 1:
        if (active) {
            muse_mode = true;
        } else {
            muse_mode = false;
        }
    }
    return false;
}

void matrix_scan_user(void) {
#ifdef AUDIO_ENABLE
    if (muse_mode) {
        if (muse_counter == 0) {
            uint8_t muse_note = muse_offset + SCALE[muse_clock_pulse()];
            if (muse_note != last_muse_note) {
                stop_note(compute_freq_for_midi_note(last_muse_note));
                play_note(compute_freq_for_midi_note(muse_note), 0xF);
                last_muse_note = muse_note;
            }
        }
        muse_counter = (muse_counter + 1) % muse_tempo;
    } else {
        if (muse_counter) {
            stop_all_notes();
            muse_counter = 0;
        }
    }
#endif
}

bool music_mask_user(uint16_t keycode) {
  switch (keycode) {
    case RAISE:
    case LOWER:
        return false;
    default:
        return true;
  }
}
