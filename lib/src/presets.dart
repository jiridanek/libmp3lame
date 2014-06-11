/*
 * presets.c -- Apply presets
 *
 *	Copyright (c) 2002-2008 Gabriel Bouvigne
 *	Copyright (c) 2007-2011 Robert Hegemann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
 */

part of libmp3lame;


//#ifdef HAVE_CONFIG_H
//# include <config.h>
//#endif
//
//#include "lame.h"
//#include "machine.h"
//#include "set_get.h"
//#include "encoder.h"
//#include "util.h"
//#include "lame_global_flags.h"

//#define SET_OPTION(opt, val, def) if (enforce) \
//    (void) lame_set_##opt(gfp, val); \
//    else if (!(fabs(lame_get_##opt(gfp) - def) > 0)) \
//    (void) lame_set_##opt(gfp, val);
//
//#define SET__OPTION(opt, val, def) if (enforce) \
//    lame_set_##opt(gfp, val); \
//    else if (!(fabs(lame_get_##opt(gfp) - def) > 0)) \
//    lame_set_##opt(gfp, val);

//#undef Min
//#undef Max

int
min_int(int a, int b)
{
    if (a < b) {
        return a;
    }
    return b;
}

int
max_int(int a, int b)
{
    if (a > b) {
        return a;
    }
    return b;
}



class vbr_presets_t {
    final int     vbr_q;
    final int     quant_comp;
    final int     quant_comp_s;
    final int     expY;
    final double   st_lrm;          /*short threshold */
    final double   st_s;
    final double   masking_adj;
    final double   masking_adj_short;
    final double   ath_lower;
    final double   ath_curve;
    final double   ath_sensitivity;
    final double   interch;
    final int     safejoint;
    final int     sfb21mod;
    final double   msfix;
    final double   minval;
    final double   ath_fixpoint;
//    const vbr_presets_t(this.vbr_q, this.quant_comp, this.quant_comp_s, this.expY,
//        this.st_lrm, this.st_s, this.mask, this.adj_l, this.adj_s, this.ath_lower,
//        this.ath_curve, this.ath_sensitivity, this.interch, this.safejoint, this.sfb21mod, this.msfix);
    const vbr_presets_t(this.vbr_q, this.quant_comp, this.quant_comp_s, this.expY,
            this.st_lrm, this.st_s, this.masking_adj, this.masking_adj_short, this.ath_lower,
            this.ath_curve, this.ath_sensitivity, this.interch, this.safejoint, this.sfb21mod,
            this.msfix, this.minval, this.ath_fixpoint);
}

    /* *INDENT-OFF* */

    /* Switch mappings for VBR mode VBR_RH */
    const vbr_old_switch_map = const [
    /*vbr_q  qcomp_l  qcomp_s  expY  st_lrm   st_s  mask adj_l  adj_s  ath_lower  ath_curve  ath_sens  interChR  safejoint sfb21mod  msfix */
        const vbr_presets_t(0,       9,       9,    0,   5.20, 125.0,      -4.2,   -6.3,       4.8,       1,          0,   0,              2,      21,  0.97, 5, 100),
        const vbr_presets_t(1,       9,       9,    0,   5.30, 125.0,      -3.6,   -5.6,       4.5,       1.5,        0,   0,              2,      21,  1.35, 5, 100),
        const vbr_presets_t(2,       9,       9,    0,   5.60, 125.0,      -2.2,   -3.5,       2.8,       2,          0,   0,              2,      21,  1.49, 5, 100),
        const vbr_presets_t(3,       9,       9,    1,   5.80, 130.0,      -1.8,   -2.8,       2.6,       3,         -4,   0,              2,      20,  1.64, 5, 100),
        const vbr_presets_t(4,       9,       9,    1,   6.00, 135.0,      -0.7,   -1.1,       1.1,       3.5,       -8,   0,              2,       0,  1.79, 5, 100),
        const vbr_presets_t(5,       9,       9,    1,   6.40, 140.0,       0.5,    0.4,      -7.5,       4,        -12,   0.0002,         0,       0,  1.95, 5, 100),
        const vbr_presets_t(6,       9,       9,    1,   6.60, 145.0,       0.67,   0.65,    -14.7,       6.5,      -19,   0.0004,         0,       0,  2.30, 5, 100),
        const vbr_presets_t(7,       9,       9,    1,   6.60, 145.0,       0.8,    0.75,    -19.7,       8,        -22,   0.0006,         0,       0,  2.70, 5, 100),
        const vbr_presets_t(8,       9,       9,    1,   6.60, 145.0,       1.2,    1.15,    -27.5,      10,        -23,   0.0007,         0,       0,  0,    5, 100),
        const vbr_presets_t(9,       9,       9,    1,   6.60, 145.0,       1.6,    1.6,     -36,        11,        -25,   0.0008,         0,       0,  0,    5, 100),
        const vbr_presets_t(10,      9,       9,    1,   6.60, 145.0,       2.0,    2.0,     -36,        12,        -25,   0.0008,         0,       0,  0,    5, 100)
    ];

    const  vbr_mt_psy_switch_map = const [
    /*vbr_q  qcomp_l  qcomp_s  expY  st_lrm   st_s  mask adj_l  adj_s  ath_lower  ath_curve  ath_sens  ---  safejoint sfb21mod  msfix */
        const vbr_presets_t(0,       9,       9,    0,   4.20,  25.0,      -6.8,   -6.8,       7.1,       1,          0,   0,         2,      31,  1.000,  5, 100),
        const vbr_presets_t(1,       9,       9,    0,   4.20,  25.0,      -4.8,   -4.8,       5.4,       1.4,       -1,   0,         2,      27,  1.122,  5,  98),
        const vbr_presets_t(2,       9,       9,    0,   4.20,  25.0,      -2.6,   -2.6,       3.7,       2.0,       -3,   0,         2,      23,  1.288,  5,  97),
        const vbr_presets_t(3,       9,       9,    1,   4.20,  25.0,      -1.6,   -1.6,       2.0,       2.0,       -5,   0,         2,      18,  1.479,  5,  96),
        const vbr_presets_t(4,       9,       9,    1,   4.20,  25.0,      -0.0,   -0.0,       0.0,       2.0,       -8,   0,         2,      12,  1.698,  5,  95),
        const vbr_presets_t(5,       9,       9,    1,   4.20,  25.0,       1.3,    1.3,      -6,         3.5,      -11,   0,         2,       8,  1.950,  5,  94.2),
//#if 0
//        {6,       9,       9,    1,   4.50, 100.0,       1.5,    1.5,     -24.0,       6.0,      -14,   0,         2,       4,  2.239,  3,  93.9},
//        {7,       9,       9,    1,   4.80, 200.0,       1.7,    1.7,     -28.0,       9.0,      -20,   0,         2,       0,  2.570,  1,  93.6},
//#else
        const vbr_presets_t(6,       9,       9,    1,   4.50, 100.0,       2.2,    2.3,     -12.0,       6.0,      -14,   0,         2,       4,  2.239,  3,  93.9),
        const vbr_presets_t(7,       9,       9,    1,   4.80, 200.0,       2.7,    2.7,     -18.0,       9.0,      -17,   0,         2,       0,  2.570,  1,  93.6),
//#endif
        const vbr_presets_t(8,       9,       9,    1,   5.30, 300.0,       2.8,    2.8,     -21.0,      10.0,      -23,   0.0002,    0,       0,  2.951,  0,  93.3),
        const vbr_presets_t(9,       9,       9,    1,   6.60, 300.0,       2.8,    2.8,     -23.0,      11.0,      -25,   0.0006,    0,       0,  3.388,  0,  93.3),
        const vbr_presets_t(10,      9,       9,    1,  25.00, 300.0,       2.8,    2.8,     -25.0,      12.0,      -27,   0.0025,    0,       0,  3.500,  0,  93.3)
    ];

    /* *INDENT-ON* */

List<vbr_presets_t>
get_vbr_preset(int v)
{
    switch (v) {
    case vbr_mtrh:
    case vbr_mt:
        return vbr_mt_psy_switch_map;
    default:
        return vbr_old_switch_map;
    }
}

#define NOOP(m) (void)p.m
#define LERP(m) (p.m = p.m + x * (q.m - p.m))

void
apply_vbr_preset(lame_global_flags gfp, int a, int enforce)
{
    vbr_presets_t vbr_preset = get_vbr_preset(lame_get_VBR(gfp));
    float   x = gfp.VBR_q_frac;
    vbr_presets_t p = vbr_preset[a];
    vbr_presets_t q = vbr_preset[a + 1];
    vbr_presets_t const *set = &p;

//    NOOP(vbr_q);
//    NOOP(quant_comp);
//    NOOP(quant_comp_s);
//    NOOP(expY);
    /*LERP(st_lrm);*/ (p.st_lrm = p.st_lrm + x * (q.st_lrm - p.st_lrm));
    /*LERP(st_s);*/ (p.st_s = p.st_s + x * (q.st_s - p.st_s));
    /*LERP(masking_adj);*/ (p.masking_adj = p.masking_adj + x * (q.masking_adj - p.masking_adj));
    /*LERP(masking_adj_short);*/ (p.masking_adj_short = p.masking_adj_short + x * (q.masking_adj_short - p.masking_adj_short));
    /*LERP(ath_lower);*/ (p.ath_lower = p.ath_lower + x * (q.ath_lower - p.ath_lower));
    /*LERP(ath_curve);*/ (p.ath_curve = p.ath_curve + x * (q.ath_curve - p.ath_curve));
    /*LERP(ath_sensitivity);*/ (p.ath_sensitivity = p.ath_sensitivity + x * (q.ath_sensitivity - p.ath_sensitivity));
    /*LERP(interch);*/ (p.interch = p.interch + x * (q.interch - p.interch));
//    NOOP(safejoint);*/ (p.m = p.m + x * (q.m - p.m));
    /*LERP(sfb21mod);*/ (p.sfb21mod = p.sfb21mod + x * (q.sfb21mod - p.sfb21mod));
    /*LERP(msfix);*/ (p.msfix = p.msfix + x * (q.msfix - p.msfix));
    /*LERP(minval);*/ (p.minval = p.minval + x * (q.minval - p.minval));
    /*LERP(ath_fixpoint);*/ (p.ath_fixpoint = p.ath_fixpoint + x * (q.ath_fixpoint - p.ath_fixpoint));

    lame_set_VBR_q(gfp, set.vbr_q);
    SET_OPTION(quant_comp, set.quant_comp, -1);
    SET_OPTION(quant_comp_short, set.quant_comp_s, -1);
    if (set.expY) {
        lame_set_experimentalY(gfp, set.expY);
    }
    SET_OPTION(short_threshold_lrm, set.st_lrm, -1);
    SET_OPTION(short_threshold_s, set.st_s, -1);
    SET_OPTION(maskingadjust, set.masking_adj, 0);
    SET_OPTION(maskingadjust_short, set.masking_adj_short, 0);
    if (lame_get_VBR(gfp) == vbr_mt || lame_get_VBR(gfp) == vbr_mtrh) {
        lame_set_ATHtype(gfp, 5);
    }
    SET_OPTION(ATHlower, set.ath_lower, 0);
    SET_OPTION(ATHcurve, set.ath_curve, -1);
    SET_OPTION(athaa_sensitivity, set.ath_sensitivity, 0);
    if (set.interch > 0) {
        SET_OPTION(interChRatio, set.interch, -1);
    }

    /* parameters for which there is no proper set/get interface */
    if (set.safejoint > 0) {
        lame_set_exp_nspsytune(gfp, lame_get_exp_nspsytune(gfp) | 2);
    }
    if (set.sfb21mod > 0) {
        int nsp = lame_get_exp_nspsytune(gfp);
        int val = (nsp >> 20) & 63;
        if (val == 0) {
            int sf21mod = (set.sfb21mod << 20) | nsp;
            lame_set_exp_nspsytune(gfp, sf21mod);
        }
    }
    SET__OPTION(msfix, set.msfix, -1);

    if (enforce == 0) {
        gfp.VBR_q = a;
        gfp.VBR_q_frac = x;
    }
    gfp.internal_flags.cfg.minval = set.minval;
    gfp.internal_flags.cfg.ATHfixpoint = set.ath_fixpoint;
}

class abr_presets_t {
        final int     abr_kbps;
        final int     quant_comp;
        final int     quant_comp_s;
        final int     safejoint;
        final double   nsmsfix;
        final double   st_lrm;      /*short threshold */
        final double   st_s;
        final double   scale;
        final double   masking_adj;
        final double   ath_lower;
        final double   ath_curve;
        final double   interch;
        final int     sfscale;
  const abr_presets_t(this.abr_kbps, this.quant_comp, this.quant_comp_s, this.safejoint, this.nsmsfix,
      this.st_lrm, this.st_s, this.scale, this.masking_adj, this.ath_lower, this.ath_curve, this.interch, this.sfscale);
    }

int
apply_abr_preset(lame_global_flags gfp, int preset, int enforce)
{



    /* *INDENT-OFF* */

    /*
     *  Switch mappings for ABR mode
     */
    const abr_switch_map = const [
    /* kbps  quant q_s safejoint nsmsfix st_lrm  st_s  scale   msk ath_lwr ath_curve  interch , sfscale */
      const abr_presets_t(  8,     9,  9,        0,      0,  6.60,  145,  0.95,    0,  -30.0,     11,    0.0012,        1), /*   8, impossible to use in stereo */
      const abr_presets_t( 16,     9,  9,        0,      0,  6.60,  145,  0.95,    0,  -25.0,     11,    0.0010,        1), /*  16 */
      const abr_presets_t( 24,     9,  9,        0,      0,  6.60,  145,  0.95,    0,  -20.0,     11,    0.0010,        1), /*  24 */
      const abr_presets_t( 32,     9,  9,        0,      0,  6.60,  145,  0.95,    0,  -15.0,     11,    0.0010,        1), /*  32 */
      const abr_presets_t( 40,     9,  9,        0,      0,  6.60,  145,  0.95,    0,  -10.0,     11,    0.0009,        1), /*  40 */
      const abr_presets_t( 48,     9,  9,        0,      0,  6.60,  145,  0.95,    0,  -10.0,     11,    0.0009,        1), /*  48 */
      const abr_presets_t( 56,     9,  9,        0,      0,  6.60,  145,  0.95,    0,   -6.0,     11,    0.0008,        1), /*  56 */
      const abr_presets_t( 64,     9,  9,        0,      0,  6.60,  145,  0.95,    0,   -2.0,     11,    0.0008,        1), /*  64 */
      const abr_presets_t( 80,     9,  9,        0,      0,  6.60,  145,  0.95,    0,     .0,      8,    0.0007,        1), /*  80 */
      const abr_presets_t( 96,     9,  9,        0,   2.50,  6.60,  145,  0.95,    0,    1.0,      5.5,  0.0006,        1), /*  96 */
      const abr_presets_t(112,     9,  9,        0,   2.25,  6.60,  145,  0.95,    0,    2.0,      4.5,  0.0005,        1), /* 112 */
      const abr_presets_t(128,     9,  9,        0,   1.95,  6.40,  140,  0.95,    0,    3.0,      4,    0.0002,        1), /* 128 */
      const abr_presets_t(160,     9,  9,        1,   1.79,  6.00,  135,  0.95,   -2,    5.0,      3.5,  0,             1), /* 160 */
      const abr_presets_t(192,     9,  9,        1,   1.49,  5.60,  125,  0.97,   -4,    7.0,      3,    0,             0), /* 192 */
      const abr_presets_t(224,     9,  9,        1,   1.25,  5.20,  125,  0.98,   -6,    9.0,      2,    0,             0), /* 224 */
      const abr_presets_t(256,     9,  9,        1,   0.97,  5.20,  125,  1.00,   -8,   10.0,      1,    0,             0), /* 256 */
      const abr_presets_t(320,     9,  9,        1,   0.90,  5.20,  125,  1.00,  -10,   12.0,      0,    0,             0)  /* 320 */
    ];

    /* *INDENT-ON* */

    /* Variables for the ABR stuff */
    int     r;
    int     actual_bitrate = preset;

    r = nearestBitrateFullIndex(preset);

    lame_set_VBR(gfp, vbr_abr);
    lame_set_VBR_mean_bitrate_kbps(gfp, (actual_bitrate));
    lame_set_VBR_mean_bitrate_kbps(gfp, min_int(lame_get_VBR_mean_bitrate_kbps(gfp), 320));
    lame_set_VBR_mean_bitrate_kbps(gfp, max_int(lame_get_VBR_mean_bitrate_kbps(gfp), 8));
    lame_set_brate(gfp, lame_get_VBR_mean_bitrate_kbps(gfp));


    /* parameters for which there is no proper set/get interface */
    if (abr_switch_map[r].safejoint > 0)
        lame_set_exp_nspsytune(gfp, lame_get_exp_nspsytune(gfp) | 2); /* safejoint */

    if (abr_switch_map[r].sfscale > 0)
        lame_set_sfscale(gfp, 1);


    SET_OPTION(quant_comp, abr_switch_map[r].quant_comp, -1);
    SET_OPTION(quant_comp_short, abr_switch_map[r].quant_comp_s, -1);

    SET__OPTION(msfix, abr_switch_map[r].nsmsfix, -1);

    SET_OPTION(short_threshold_lrm, abr_switch_map[r].st_lrm, -1);
    SET_OPTION(short_threshold_s, abr_switch_map[r].st_s, -1);

    /* ABR seems to have big problems with clipping, especially at low bitrates */
    /* so we compensate for that here by using a scale value depending on bitrate */
    lame_set_scale(gfp, lame_get_scale(gfp) * abr_switch_map[r].scale);

    SET_OPTION(maskingadjust, abr_switch_map[r].masking_adj, 0);
    if (abr_switch_map[r].masking_adj > 0) {
        SET_OPTION(maskingadjust_short, abr_switch_map[r].masking_adj * .9, 0);
    }
    else {
        SET_OPTION(maskingadjust_short, abr_switch_map[r].masking_adj * 1.1, 0);
    }


    SET_OPTION(ATHlower, abr_switch_map[r].ath_lower, 0);
    SET_OPTION(ATHcurve, abr_switch_map[r].ath_curve, -1);

    SET_OPTION(interChRatio, abr_switch_map[r].interch, -1);

    abr_switch_map[r].abr_kbps;

    gfp.internal_flags.cfg.minval = 5.0 * (abr_switch_map[r].abr_kbps / 320.0);

    return preset;
}



int
apply_preset(lame_global_flags gfp, int preset, int enforce)
{
    /*translate legacy presets */
    switch (preset) {
    case R3MIX:
        {
            preset = V3;
            lame_set_VBR(gfp, vbr_mtrh);
            break;
        }
    case MEDIUM:
    case MEDIUM_FAST:
        {
            preset = V4;
            lame_set_VBR(gfp, vbr_mtrh);
            break;
        }
    case STANDARD:
    case STANDARD_FAST:
        {
            preset = V2;
            lame_set_VBR(gfp, vbr_mtrh);
            break;
        }
    case EXTREME:
    case EXTREME_FAST:
        {
            preset = V0;
            lame_set_VBR(gfp, vbr_mtrh);
            break;
        }
    case INSANE:
        {
            preset = 320;
            gfp.preset = preset;
            apply_abr_preset(gfp, preset, enforce);
            lame_set_VBR(gfp, vbr_off);
            return preset;
        }
    }

    gfp.preset = preset;
    {
        switch (preset) {
        case V9:
            apply_vbr_preset(gfp, 9, enforce);
            return preset;
        case V8:
            apply_vbr_preset(gfp, 8, enforce);
            return preset;
        case V7:
            apply_vbr_preset(gfp, 7, enforce);
            return preset;
        case V6:
            apply_vbr_preset(gfp, 6, enforce);
            return preset;
        case V5:
            apply_vbr_preset(gfp, 5, enforce);
            return preset;
        case V4:
            apply_vbr_preset(gfp, 4, enforce);
            return preset;
        case V3:
            apply_vbr_preset(gfp, 3, enforce);
            return preset;
        case V2:
            apply_vbr_preset(gfp, 2, enforce);
            return preset;
        case V1:
            apply_vbr_preset(gfp, 1, enforce);
            return preset;
        case V0:
            apply_vbr_preset(gfp, 0, enforce);
            return preset;
        default:
            break;
        }
    }
    if (8 <= preset && preset <= 320) {
        return apply_abr_preset(gfp, preset, enforce);
    }

    gfp.preset = 0;    /*no corresponding preset found */
    return preset;
}
