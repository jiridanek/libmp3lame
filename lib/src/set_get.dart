/* -*- mode: C; mode: fold -*- */
/*
 * set/get functions for lame_global_flags
 *
 * Copyright (c) 2001-2005 Alexander Leidinger
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
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

/* $Id: set_get.c,v 1.98 2011/05/07 16:05:17 rbrito Exp $ */

//#ifdef HAVE_CONFIG_H
//# include <config.h>
//#endif
//
//#include "lame.h"
//#include "machine.h"
//#include "encoder.h"
//#include "util.h"
//#include "bitstream.h"  /* because of compute_flushbits */
//
//#include "set_get.h"

part of libmp3lame;

//#ifndef lame_internal_flags_defined
//#define lame_internal_flags_defined
//struct lame_internal_flags;
//typedef struct lame_internal_flags lame_internal_flags;
//#endif


class short_block_t {
    static const short_block_not_set = const short_block_t._(-1); /* allow LAME to decide */
    static const short_block_allowed = const short_block_t._(0); /* LAME may use them, even different block types for L/R */
    static const short_block_coupled = const short_block_t._(1); /* LAME may use them, but always same block types in L/R */
    static const short_block_dispensed = const short_block_t._(2); /* LAME will not use short blocks, long blocks only */
    static const short_block_forced = const short_block_t._(3); /* LAME will not use long blocks, short blocks only */

    final int value;
    const short_block_t._(this.value);
}

/***********************************************************************
*
*  Control Parameters set by User.  These parameters are here for
*  backwards compatibility with the old, non-shared lib API.
*  Please use the lame_set_variablename() functions below
*
*
***********************************************************************/


class report_t {
  var msgf;
  var debugf;
  var errorf;
//          void    (*msgf) (const char *format, va_list ap);
//          void    (*debugf) (const char *format, va_list ap);
//          void    (*errorf) (const char *format, va_list ap);
}

class asm_optimizations_t {
  int     mmx;
  int     amd3dnow;
  int     sse;
}

//int     is_lame_global_flags_valid();

//class float {
//  double a;
//  float(this.a);
//  operator + (b) => a + b;
//  operator - (b) => a - b;
//  operator * (b) => a * b;
//}

class lame_global_flags {
  int class_id;

  /* input description */
  int num_samples; /* number of samples. default=2^32-1           */
  int     num_channels;    /* input number of channels. default=2         */
  int     samplerate_in;   /* input_samp_rate in Hz. default=44.1 kHz     */
  int     samplerate_out;  /* output_samp_rate.
                              default: LAME picks best value
                              at least not used for MP3 decoding:
                              Remember 44.1 kHz MP3s and AC97           */
  double   scale;           /* scale input by this amount before encoding
                              at least not used for MP3 decoding          */
  double   scale_left;      /* scale input of channel 0 (left) by this
                              amount before encoding                      */
  double   scale_right;     /* scale input of channel 1 (right) by this
                              amount before encoding                      */

  /* general control params */
  int     analysis;        /* collect data for a MP3 frame analyzer?      */
  int     write_lame_tag;  /* add Xing VBR tag?                           */
  int     decode_only;     /* use lame/mpglib to convert mp3 to wav       */
  int     quality;         /* quality setting 0=best,  9=worst  default=5 */
  MPEG_mode mode;          /* see enum in lame.h
                              default = LAME picks best value             */
  int     force_ms;        /* force M/S mode.  requires mode=1            */
  int     free_format;     /* use free format? default=0                  */
  int     findReplayGain;  /* find the RG value? default=0       */
  int     decode_on_the_fly; /* decode on the fly? default=0                */
  int     write_id3tag_automatic; /* 1 (default) writes ID3 tags, 0 not */

  int     nogap_total;
  int     nogap_current;

  int     substep_shaping;
  int     noise_shaping;
  int     subblock_gain;   /*  0 = no, 1 = yes */
  int     use_best_huffman; /* 0 = no.  1=outside loop  2=inside loop(slow) */

  /*
   * set either brate>0  or compression_ratio>0, LAME will compute
   * the value of the variable not set.
   * Default is compression_ratio = 11.025
   */
  int     brate;           /* bitrate                                    */
  double   compression_ratio; /* sizeof(wav file)/sizeof(mp3 file)          */


  /* frame params */
  int     copyright;       /* mark as copyright. default=0           */
  int     original;        /* mark as original. default=1            */
  int     extension;       /* the MP3 'private extension' bit.
                              Meaningless                            */
  int     emphasis;        /* Input PCM is emphased PCM (for
                              instance from one of the rarely
                              emphased CDs), it is STRONGLY not
                              recommended to use this, because
                              psycho does not take it into account,
                              and last but not least many decoders
                              don't care about these bits          */
  int     error_protection; /* use 2 bytes per frame for a CRC
                               checksum. default=0                    */
  int     strict_ISO;      /* enforce ISO spec as much as possible   */

  int     disable_reservoir; /* use bit reservoir?                     */

  /* quantization/noise shaping */
  int     quant_comp;
  int     quant_comp_short;
  int     experimentalY;
  int     experimentalZ;
  int     exp_nspsytune;

  int     preset;

  /* VBR control */
  vbr_mode VBR;
  double   VBR_q_frac;      /* Range [0,...,1[ */
  int     VBR_q;           /* Range [0,...,9] */
  int     VBR_mean_bitrate_kbps;
  int     VBR_min_bitrate_kbps;
  int     VBR_max_bitrate_kbps;
  int     VBR_hard_min;    /* strictly enforce VBR_min_bitrate
                              normaly, it will be violated for analog
                              silence                                 */


  /* resampling and filtering */
  int     lowpassfreq;     /* freq in Hz. 0=lame choses.
                              -1=no filter                          */
  int     highpassfreq;    /* freq in Hz. 0=lame choses.
                              -1=no filter                          */
  int     lowpasswidth;    /* freq width of filter, in Hz
                              (default=15%)                         */
  int     highpasswidth;   /* freq width of filter, in Hz
                              (default=15%)                         */



  /*
   * psycho acoustics and other arguments which you should not change
   * unless you know what you are doing
   */
  double   maskingadjust;
  double   maskingadjust_short;
  int     ATHonly;         /* only use ATH                         */
  int     ATHshort;        /* only use ATH for short blocks        */
  int     noATH;           /* disable ATH                          */
  int     ATHtype;         /* select ATH formula                   */
  double   ATHcurve;        /* change ATH formula 4 shape           */
  double   ATH_lower_db;    /* lower ATH by this many db            */
  int     athaa_type;      /* select ATH auto-adjust scheme        */
  double   athaa_sensitivity; /* dB, tune active region of auto-level */
  short_block_t short_blocks;
  int     useTemporal;     /* use temporal masking effect          */
  double   interChRatio;
  double   msfix;           /* Naoki's adjustment of Mid/Side maskings */

  int     tune;            /* 0 off, 1 on */
  double   tune_value_a;    /* used to pass values for debugging and stuff */

  double   attackthre;      /* attack threshold for L/R/M channel */
  double   attackthre_s;    /* attack threshold for S channel */


  report_t report;

/************************************************************************/
  /* internal variables, do not set...                                    */
  /* provided because they may be of use to calling application           */
/************************************************************************/

  int     lame_allocated_gfp; /* is this struct owned by calling
                                 program or lame?                     */



/**************************************************************************/
  /* more internal variables are stored in this structure:                  */
/**************************************************************************/
  lame_internal_flags internal_flags;

  asm_optimizations_t asm_optimizations;



  bool
    is_lame_global_flags_valid()
    {
        if (this == null)
            return false;
        if (this.class_id != LAME_ID)
            return false;
        return true;
    }

  /*
   * input stream description
   */




  /* number of samples */
  /* it's unlikely for this function to return an error */
  int
  lame_set_num_samples(int num_samples)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 2^32-1 */
          this.num_samples = num_samples;
          return 0;
      }
      return -1;
  }

  int
  lame_get_num_samples()
  {
      if (is_lame_global_flags_valid()) {
          return this.num_samples;
      }
      return 0;
  }


  /* input samplerate */
  int
  lame_set_in_samplerate(int in_samplerate)
  {
      if (is_lame_global_flags_valid()) {
          /* input sample rate in Hz,  default = 44100 Hz */
          this.samplerate_in = in_samplerate;
          return 0;
      }
      return -1;
  }

  int
  lame_get_in_samplerate()
  {
      if (is_lame_global_flags_valid()) {
          return this.samplerate_in;
      }
      return 0;
  }


  /* number of channels in input stream */
  int
  lame_set_num_channels(int num_channels)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 2 */
          if (2 < num_channels || 0 == num_channels) {
              return -1;  /* we don't support more than 2 channels */
          }
          this.num_channels = num_channels;
          return 0;
      }
      return -1;
  }

  int
  lame_get_num_channels()
  {
      if (is_lame_global_flags_valid()) {
          return this.num_channels;
      }
      return 0;
  }


  /* scale the input by this amount before encoding (not used for decoding) */
  int
  lame_set_scale(float scale)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 1 */
          this.scale = scale;
          return 0;
      }
      return -1;
  }

  float
  lame_get_scale()
  {
      if (is_lame_global_flags_valid()) {
          return this.scale;
      }
      return 0;
  }


  /* scale the channel 0 (left) input by this amount before
     encoding (not used for decoding) */
  int
  lame_set_scale_left(float scale)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 1 */
          this.scale_left = scale;
          return 0;
      }
      return -1;
  }

  float
  lame_get_scale_left()
  {
      if (is_lame_global_flags_valid()) {
          return this.scale_left;
      }
      return 0;
  }


  /* scale the channel 1 (right) input by this amount before
     encoding (not used for decoding) */
  int
  lame_set_scale_right(float scale)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 1 */
          this.scale_right = scale;
          return 0;
      }
      return -1;
  }

  double
  lame_get_scale_right()
  {
      if (is_lame_global_flags_valid()) {
          return this.scale_right;
      }
      return 0;
  }


  /* output sample rate in Hz */
  int
  lame_set_out_samplerate(int out_samplerate)
  {
      if (is_lame_global_flags_valid()) {
          /*
           * default = 0: LAME picks best value based on the amount
           *              of compression
           * MPEG only allows:
           *  MPEG1    32, 44.1,   48khz
           *  MPEG2    16, 22.05,  24
           *  MPEG2.5   8, 11.025, 12
           *
           * (not used by decoding routines)
           */
          this.samplerate_out = out_samplerate;
          return 0;
      }
      return -1;
  }

  int
  lame_get_out_samplerate()
  {
      if (is_lame_global_flags_valid()) {
          return this.samplerate_out;
      }
      return 0;
  }




  /*
   * general control parameters
   */

  /* collect data for an MP3 frame analzyer */
  int
  lame_set_analysis(int analysis)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 0 */

          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (0 > analysis || 1 < analysis)
              return -1;
          this.analysis = analysis;
          return 0;
      }
      return -1;
  }

  int
  lame_get_analysis()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.analysis && 1 >= this.analysis);
          return this.analysis;
      }
      return 0;
  }


  /* write a Xing VBR header frame */
  int
  lame_set_bWriteVbrTag(int bWriteVbrTag)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 1 (on) for VBR/ABR modes, 0 (off) for CBR mode */

          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (0 > bWriteVbrTag || 1 < bWriteVbrTag)
              return -1;
          this.write_lame_tag = bWriteVbrTag;
          return 0;
      }
      return -1;
  }

  int
  lame_get_bWriteVbrTag()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.write_lame_tag && 1 >= this.write_lame_tag);
          return this.write_lame_tag;
      }
      return 0;
  }



  /* decode only, use lame/mpglib to convert mp3 to wav */
  int
  lame_set_decode_only(int decode_only)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 0 (disabled) */

          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (0 > decode_only || 1 < decode_only)
              return -1;
          this.decode_only = decode_only;
          return 0;
      }
      return -1;
  }

  int
  lame_get_decode_only()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.decode_only && 1 >= this.decode_only);
          return this.decode_only;
      }
      return 0;
  }


//  #if DEPRECATED_OR_OBSOLETE_CODE_REMOVED
//  /* 1=encode a Vorbis .ogg file.  default=0 */
//  /* DEPRECATED */
//  int CDECL lame_set_ogg(lame_global_flags *, int);
//  int CDECL lame_get_ogg(const lame_global_flags *);
//  #else
//  #endif
//
//  /* encode a Vorbis .ogg file */
//  /* DEPRECATED */
//  int
//  lame_set_ogg(int ogg)
//  {
//      (void) gfp;
//      (void) ogg;
//      return -1;
//  }
//
//  int
//  lame_get_ogg()
//  {
//      (void) gfp;
//      return 0;
//  }


  /*
   * Internal algorithm selection.
   * True quality is determined by the bitrate but this variable will effect
   * quality by selecting expensive or cheap algorithms.
   * quality=0..9.  0=best (very slow).  9=worst.
   * recommended:  3     near-best quality, not too slow
   *               5     good quality, fast
   *               7     ok quality, really fast
   */
  int
  lame_set_quality(int quality)
  {
      if (is_lame_global_flags_valid()) {
          if (quality < 0) {
              this.quality = 0;
          }
          else if (quality > 9) {
              this.quality = 9;
          }
          else {
              this.quality = quality;
          }
          return 0;
      }
      return -1;
  }

  int
  lame_get_quality()
  {
      if (is_lame_global_flags_valid()) {
          return this.quality;
      }
      return 0;
  }


  /* mode = STEREO, JOINT_STEREO, DUAL_CHANNEL (not supported), MONO */
  int
  lame_set_mode(MPEG_mode mode)
  {
      if (is_lame_global_flags_valid()) {
          int     mpg_mode = mode;
          /* default: lame chooses based on compression ratio and input channels */
          if (mpg_mode < 0 || MAX_INDICATOR <= mpg_mode)
              return -1;  /* Unknown MPEG mode! */
          this.mode = mode;
          return 0;
      }
      return -1;
  }

  MPEG_mode
  lame_get_mode()
  {
      if (is_lame_global_flags_valid()) {
          assert(this.mode < MAX_INDICATOR);
          return this.mode;
      }
      return NOT_SET;
  }


//  #if DEPRECATED_OR_OBSOLETE_CODE_REMOVED
//  /*
//    mode_automs.  Use a M/S mode with a switching threshold based on
//    compression ratio
//    DEPRECATED
//  */
//  int CDECL lame_set_mode_automs(lame_global_flags *, int);
//  int CDECL lame_get_mode_automs(const lame_global_flags *);
//  #else
//  #endif

  /* Us a M/S mode with a switching threshold based on compression ratio */
  /* DEPRECATED */
  int
  lame_set_mode_automs(int mode_automs)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 0 (disabled) */

          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (0 > mode_automs || 1 < mode_automs)
              return -1;
          lame_set_mode(gfp, JOINT_STEREO);
          return 0;
      }
      return -1;
  }

  int
  lame_get_mode_automs()
  {
//      (void) gfp;
      return 1;
  }


  /*
   * Force M/S for all frames.  For testing only.
   * Requires mode = 1.
   */
  int
  lame_set_force_ms(int force_ms)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 0 (disabled) */

          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (0 > force_ms || 1 < force_ms)
              return -1;
          this.force_ms = force_ms;
          return 0;
      }
      return -1;
  }

  int
  lame_get_force_ms()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.force_ms && 1 >= this.force_ms);
          return this.force_ms;
      }
      return 0;
  }


  /* Use free_format. */
  int
  lame_set_free_format(int free_format)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 0 (disabled) */

          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (0 > free_format || 1 < free_format)
              return -1;
          this.free_format = free_format;
          return 0;
      }
      return -1;
  }

  int
  lame_get_free_format()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.free_format && 1 >= this.free_format);
          return this.free_format;
      }
      return 0;
  }



  /* Perform ReplayGain analysis */
  int
  lame_set_findReplayGain(int findReplayGain)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 0 (disabled) */

          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (0 > findReplayGain || 1 < findReplayGain)
              return -1;
          this.findReplayGain = findReplayGain;
          return 0;
      }
      return -1;
  }

  int
  lame_get_findReplayGain()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.findReplayGain && 1 >= this.findReplayGain);
          return this.findReplayGain;
      }
      return 0;
  }


  /* Decode on the fly. Find the peak sample. If ReplayGain analysis is
     enabled then perform it on the decoded data. */
  int
  lame_set_decode_on_the_fly(int decode_on_the_fly)
  {
      if (is_lame_global_flags_valid()) {
//  #ifndef DECODE_ON_THE_FLY
          return -1;
//  #else
//          /* default = 0 (disabled) */
//
//          /* enforce disable/enable meaning, if we need more than two values
//             we need to switch to an enum to have an apropriate representation
//             of the possible meanings of the value */
//          if (0 > decode_on_the_fly || 1 < decode_on_the_fly)
//              return -1;
//
//          this.decode_on_the_fly = decode_on_the_fly;
//
//          return 0;
//  #endif
      }
      return -1;
  }

  int
  lame_get_decode_on_the_fly()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.decode_on_the_fly && 1 >= this.decode_on_the_fly);
          return this.decode_on_the_fly;
      }
      return 0;
  }

//  #if DEPRECATED_OR_OBSOLETE_CODE_REMOVED
//  /* DEPRECATED: now does the same as lame_set_findReplayGain()
//     default = 0 (disabled) */
//  int CDECL lame_set_ReplayGain_input(lame_global_flags *, int);
//  int CDECL lame_get_ReplayGain_input(const lame_global_flags *);
//
//  /* DEPRECATED: now does the same as
//     lame_set_decode_on_the_fly() && lame_set_findReplayGain()
//     default = 0 (disabled) */
//  int CDECL lame_set_ReplayGain_decode(lame_global_flags *, int);
//  int CDECL lame_get_ReplayGain_decode(const lame_global_flags *);
//
//  /* DEPRECATED: now does the same as lame_set_decode_on_the_fly()
//     default = 0 (disabled) */
//  int CDECL lame_set_findPeakSample(lame_global_flags *, int);
//  int CDECL lame_get_findPeakSample(const lame_global_flags *);
//  #else
//  #endif

  /* DEPRECATED. same as lame_set_decode_on_the_fly() */
  @deprecated
  int
  lame_set_findPeakSample(int arg)
  {
      return lame_set_decode_on_the_fly(gfp, arg);
  }

  int
  lame_get_findPeakSample()
  {
      return lame_get_decode_on_the_fly(gfp);
  }

  /* DEPRECATED. same as lame_set_findReplayGain() */
  @deprecated
  int
  lame_set_ReplayGain_input(int arg)
  {
      return lame_set_findReplayGain(gfp, arg);
  }

  int
  lame_get_ReplayGain_input()
  {
      return lame_get_findReplayGain(gfp);
  }

  /* DEPRECATED. same as lame_set_decode_on_the_fly() &&
     lame_set_findReplayGain() */
  @deprecated
  int
  lame_set_ReplayGain_decode(int arg)
  {
      if (lame_set_decode_on_the_fly(gfp, arg) < 0 || lame_set_findReplayGain(gfp, arg) < 0)
          return -1;
      else
          return 0;
  }

  int
  lame_get_ReplayGain_decode()
  {
      if (lame_get_decode_on_the_fly(gfp) > 0 && lame_get_findReplayGain(gfp) > 0)
          return 1;
      else
          return 0;
  }


  /* set and get some gapless encoding flags */

  int
  lame_set_nogap_total(int the_nogap_total)
  {
      if (is_lame_global_flags_valid()) {
          this.nogap_total = the_nogap_total;
          return 0;
      }
      return -1;
  }

  int
  lame_get_nogap_total()
  {
      if (is_lame_global_flags_valid()) {
          return this.nogap_total;
      }
      return 0;
  }

  int
  lame_set_nogap_currentindex(int the_nogap_index)
  {
      if (is_lame_global_flags_valid()) {
          this.nogap_current = the_nogap_index;
          return 0;
      }
      return -1;
  }

  int
  lame_get_nogap_currentindex()
  {
      if (is_lame_global_flags_valid()) {
          return this.nogap_current;
      }
      return 0;
  }


//  /* message handlers */
//  int
//  lame_set_errorf(void (*func) (const char *, va_list))
//  {
//      if (is_lame_global_flags_valid()) {
//          this.report.errorf = func;
//          return 0;
//      }
//      return -1;
//  }
//
//  int
//  lame_set_debugf(void (*func) (const char *, va_list))
//  {
//      if (is_lame_global_flags_valid()) {
//          this.report.debugf = func;
//          return 0;
//      }
//      return -1;
//  }
//
//  int
//  lame_set_msgf(void (*func) (const char *, va_list))
//  {
//      if (is_lame_global_flags_valid()) {
//          this.report.msgf = func;
//          return 0;
//      }
//      return -1;
//  }


  /*
   * Set one of
   *  - brate
   *  - compression ratio.
   *
   * Default is compression ratio of 11.
   */
  int
  lame_set_brate(int brate)
  {
      if (is_lame_global_flags_valid()) {
          this.brate = brate;
          if (brate > 320) {
              this.disable_reservoir = 1;
          }
          return 0;
      }
      return -1;
  }

  int
  lame_get_brate()
  {
      if (is_lame_global_flags_valid()) {
          return this.brate;
      }
      return 0;
  }

  int
  lame_set_compression_ratio(float compression_ratio)
  {
      if (is_lame_global_flags_valid()) {
          this.compression_ratio = compression_ratio;
          return 0;
      }
      return -1;
  }

  float
  lame_get_compression_ratio()
  {
      if (is_lame_global_flags_valid()) {
          return this.compression_ratio;
      }
      return 0;
  }




  /*
   * frame parameters
   */

  /* Mark as copyright protected. */
  int
  lame_set_copyright(int copyright)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 0 (disabled) */

          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (0 > copyright || 1 < copyright)
              return -1;
          this.copyright = copyright;
          return 0;
      }
      return -1;
  }

  int
  lame_get_copyright()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.copyright && 1 >= this.copyright);
          return this.copyright;
      }
      return 0;
  }


  /* Mark as original. */
  int
  lame_set_original(int original)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 1 (enabled) */

          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (0 > original || 1 < original)
              return -1;
          this.original = original;
          return 0;
      }
      return -1;
  }

  int
  lame_get_original()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.original && 1 >= this.original);
          return this.original;
      }
      return 0;
  }


  /*
   * error_protection.
   * Use 2 bytes from each frame for CRC checksum.
   */
  int
  lame_set_error_protection(int error_protection)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 0 (disabled) */

          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (0 > error_protection || 1 < error_protection)
              return -1;
          this.error_protection = error_protection;
          return 0;
      }
      return -1;
  }

  int
  lame_get_error_protection()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.error_protection && 1 >= this.error_protection);
          return this.error_protection;
      }
      return 0;
  }


//  #if DEPRECATED_OR_OBSOLETE_CODE_REMOVED
//  /* padding_type. 0=pad no frames  1=pad all frames 2=adjust padding(default) */
//  int CDECL lame_set_padding_type(lame_global_flags *, Padding_type);
//  Padding_type CDECL lame_get_padding_type(const lame_global_flags *);
//  #else
//  #endif

  /*
   * padding_type.
   *  PAD_NO     = pad no frames
   *  PAD_ALL    = pad all frames
   *  PAD_ADJUST = adjust padding
   */
  int
  lame_set_padding_type(Padding_type padding_type)
  {
//      (void) gfp;
//      (void) padding_type;
      return 0;
  }

  Padding_type
  lame_get_padding_type()
  {
//      (void) gfp;
      return PAD_ADJUST;
  }


  /* MP3 'private extension' bit. Meaningless. */
  int
  lame_set_extension(int extension)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 0 (disabled) */
          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (0 > extension || 1 < extension)
              return -1;
          this.extension = extension;
          return 0;
      }
      return -1;
  }

  int
  lame_get_extension()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.extension && 1 >= this.extension);
          return this.extension;
      }
      return 0;
  }


  /* Enforce strict ISO compliance. */
  int
  lame_set_strict_ISO(int val)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 0 (disabled) */
          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (val < MDB_DEFAULT || MDB_MAXIMUM < val)
              return -1;
          this.strict_ISO = val;
          return 0;
      }
      return -1;
  }

  int
  lame_get_strict_ISO()
  {
      if (is_lame_global_flags_valid()) {
          return this.strict_ISO;
      }
      return 0;
  }




  /********************************************************************
   * quantization/noise shaping
   ***********************************************************************/

  /* Disable the bit reservoir. For testing only. */
  int
  lame_set_disable_reservoir(int disable_reservoir)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 0 (disabled) */

          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (0 > disable_reservoir || 1 < disable_reservoir)
              return -1;
          this.disable_reservoir = disable_reservoir;
          return 0;
      }
      return -1;
  }

  int
  lame_get_disable_reservoir()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.disable_reservoir && 1 >= this.disable_reservoir);
          return this.disable_reservoir;
      }
      return 0;
  }




  int
  lame_set_experimentalX(int experimentalX)
  {
      if (is_lame_global_flags_valid()) {
          lame_set_quant_comp(gfp, experimentalX);
          lame_set_quant_comp_short(gfp, experimentalX);
          return 0;
      }
      return -1;
  }

  int
  lame_get_experimentalX()
  {
      return lame_get_quant_comp(gfp);
  }


  /* Select a different "best quantization" function. default = 0 */
  int
  lame_set_quant_comp(int quant_type)
  {
      if (is_lame_global_flags_valid()) {
          this.quant_comp = quant_type;
          return 0;
      }
      return -1;
  }

  int
  lame_get_quant_comp()
  {
      if (is_lame_global_flags_valid()) {
          return this.quant_comp;
      }
      return 0;
  }


  /* Select a different "best quantization" function. default = 0 */
  int
  lame_set_quant_comp_short(int quant_type)
  {
      if (is_lame_global_flags_valid()) {
          this.quant_comp_short = quant_type;
          return 0;
      }
      return -1;
  }

  int
  lame_get_quant_comp_short()
  {
      if (is_lame_global_flags_valid()) {
          return this.quant_comp_short;
      }
      return 0;
  }


  /* Another experimental option. For testing only. */
  int
  lame_set_experimentalY(int experimentalY)
  {
      if (is_lame_global_flags_valid()) {
          this.experimentalY = experimentalY;
          return 0;
      }
      return -1;
  }

  int
  lame_get_experimentalY()
  {
      if (is_lame_global_flags_valid()) {
          return this.experimentalY;
      }
      return 0;
  }


  int
  lame_set_experimentalZ(int experimentalZ)
  {
      if (is_lame_global_flags_valid()) {
          this.experimentalZ = experimentalZ;
          return 0;
      }
      return -1;
  }

  int
  lame_get_experimentalZ()
  {
      if (is_lame_global_flags_valid()) {
          return this.experimentalZ;
      }
      return 0;
  }


  /* Naoki's psycho acoustic model. */
  int
  lame_set_exp_nspsytune(int exp_nspsytune)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 0 (disabled) */
          this.exp_nspsytune = exp_nspsytune;
          return 0;
      }
      return -1;
  }

  int
  lame_get_exp_nspsytune()
  {
      if (is_lame_global_flags_valid()) {
          return this.exp_nspsytune;
      }
      return 0;
  }




  /********************************************************************
   * VBR control
   ***********************************************************************/

  /* Types of VBR.  default = vbr_off = CBR */
  int
  lame_set_VBR(vbr_mode VBR)
  {
      if (is_lame_global_flags_valid()) {
          int     vbr_q = VBR;
          if (0 > vbr_q || vbr_max_indicator <= vbr_q)
              return -1;  /* Unknown VBR mode! */
          this.VBR = VBR;
          return 0;
      }
      return -1;
  }

  vbr_mode
  lame_get_VBR()
  {
      if (is_lame_global_flags_valid()) {
          assert(this.VBR < vbr_max_indicator);
          return this.VBR;
      }
      return vbr_off;
  }


  /*
   * VBR quality level.
   *  0 = highest
   *  9 = lowest
   */
  int
  lame_set_VBR_q(int VBR_q)
  {
      if (is_lame_global_flags_valid()) {
          int     ret = 0;

          if (0 > VBR_q) {
              ret = -1;   /* Unknown VBR quality level! */
              VBR_q = 0;
          }
          if (9 < VBR_q) {
              ret = -1;
              VBR_q = 9;
          }
          this.VBR_q = VBR_q;
          this.VBR_q_frac = 0;
          return ret;
      }
      return -1;
  }

  int
  lame_get_VBR_q()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.VBR_q && 10 > this.VBR_q);
          return this.VBR_q;
      }
      return 0;
  }

  int
  lame_set_VBR_quality(float VBR_q)
  {
      if (is_lame_global_flags_valid()) {
          int     ret = 0;

          if (0 > VBR_q) {
              ret = -1;   /* Unknown VBR quality level! */
              VBR_q = 0;
          }
          if (9.999 < VBR_q) {
              ret = -1;
              VBR_q = 9.999;
          }

          this.VBR_q = (int) VBR_q;
          this.VBR_q_frac = VBR_q - this.VBR_q;

          return ret;
      }
      return -1;
  }

  float
  lame_get_VBR_quality()
  {
      if (is_lame_global_flags_valid()) {
          return this.VBR_q + this.VBR_q_frac;
      }
      return 0;
  }


  /* Ignored except for VBR = vbr_abr (ABR mode) */
  int
  lame_set_VBR_mean_bitrate_kbps(int VBR_mean_bitrate_kbps)
  {
      if (is_lame_global_flags_valid()) {
          this.VBR_mean_bitrate_kbps = VBR_mean_bitrate_kbps;
          return 0;
      }
      return -1;
  }

  int
  lame_get_VBR_mean_bitrate_kbps()
  {
      if (is_lame_global_flags_valid()) {
          return this.VBR_mean_bitrate_kbps;
      }
      return 0;
  }

  int
  lame_set_VBR_min_bitrate_kbps(int VBR_min_bitrate_kbps)
  {
      if (is_lame_global_flags_valid()) {
          this.VBR_min_bitrate_kbps = VBR_min_bitrate_kbps;
          return 0;
      }
      return -1;
  }

  int
  lame_get_VBR_min_bitrate_kbps()
  {
      if (is_lame_global_flags_valid()) {
          return this.VBR_min_bitrate_kbps;
      }
      return 0;
  }

  int
  lame_set_VBR_max_bitrate_kbps(int VBR_max_bitrate_kbps)
  {
      if (is_lame_global_flags_valid()) {
          this.VBR_max_bitrate_kbps = VBR_max_bitrate_kbps;
          return 0;
      }
      return -1;
  }

  int
  lame_get_VBR_max_bitrate_kbps()
  {
      if (is_lame_global_flags_valid()) {
          return this.VBR_max_bitrate_kbps;
      }
      return 0;
  }


  /*
   * Strictly enforce VBR_min_bitrate.
   * Normally it will be violated for analog silence.
   */
  int
  lame_set_VBR_hard_min(int VBR_hard_min)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 0 (disabled) */

          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (0 > VBR_hard_min || 1 < VBR_hard_min)
              return -1;

          this.VBR_hard_min = VBR_hard_min;

          return 0;
      }
      return -1;
  }

  int
  lame_get_VBR_hard_min()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.VBR_hard_min && 1 >= this.VBR_hard_min);
          return this.VBR_hard_min;
      }
      return 0;
  }


  /********************************************************************
   * Filtering control
   ***********************************************************************/

  /*
   * Freqency in Hz to apply lowpass.
   *   0 = default = lame chooses
   *  -1 = disabled
   */
  int
  lame_set_lowpassfreq(int lowpassfreq)
  {
      if (is_lame_global_flags_valid()) {
          this.lowpassfreq = lowpassfreq;
          return 0;
      }
      return -1;
  }

  int
  lame_get_lowpassfreq()
  {
      if (is_lame_global_flags_valid()) {
          return this.lowpassfreq;
      }
      return 0;
  }


  /*
   * Width of transition band (in Hz).
   *  default = one polyphase filter band
   */
  int
  lame_set_lowpasswidth(int lowpasswidth)
  {
      if (is_lame_global_flags_valid()) {
          this.lowpasswidth = lowpasswidth;
          return 0;
      }
      return -1;
  }

  int
  lame_get_lowpasswidth()
  {
      if (is_lame_global_flags_valid()) {
          return this.lowpasswidth;
      }
      return 0;
  }


  /*
   * Frequency in Hz to apply highpass.
   *   0 = default = lame chooses
   *  -1 = disabled
   */
  int
  lame_set_highpassfreq(int highpassfreq)
  {
      if (is_lame_global_flags_valid()) {
          this.highpassfreq = highpassfreq;
          return 0;
      }
      return -1;
  }

  int
  lame_get_highpassfreq()
  {
      if (is_lame_global_flags_valid()) {
          return this.highpassfreq;
      }
      return 0;
  }


  /*
   * Width of transition band (in Hz).
   *  default = one polyphase filter band
   */
  int
  lame_set_highpasswidth(int highpasswidth)
  {
      if (is_lame_global_flags_valid()) {
          this.highpasswidth = highpasswidth;
          return 0;
      }
      return -1;
  }

  int
  lame_get_highpasswidth()
  {
      if (is_lame_global_flags_valid()) {
          return this.highpasswidth;
      }
      return 0;
  }




  /*
   * psycho acoustics and other arguments which you should not change
   * unless you know what you are doing
   */


  /* Adjust masking values. */
  int
  lame_set_maskingadjust(float adjust)
  {
      if (is_lame_global_flags_valid()) {
          this.maskingadjust = adjust;
          return 0;
      }
      return -1;
  }

  float
  lame_get_maskingadjust()
  {
      if (is_lame_global_flags_valid()) {
          return this.maskingadjust;
      }
      return 0;
  }

  int
  lame_set_maskingadjust_short(float adjust)
  {
      if (is_lame_global_flags_valid()) {
          this.maskingadjust_short = adjust;
          return 0;
      }
      return -1;
  }

  float
  lame_get_maskingadjust_short()
  {
      if (is_lame_global_flags_valid()) {
          return this.maskingadjust_short;
      }
      return 0;
  }

  /* Only use ATH for masking. */
  int
  lame_set_ATHonly(int ATHonly)
  {
      if (is_lame_global_flags_valid()) {
          this.ATHonly = ATHonly;
          return 0;
      }
      return -1;
  }

  int
  lame_get_ATHonly()
  {
      if (is_lame_global_flags_valid()) {
          return this.ATHonly;
      }
      return 0;
  }


  /* Only use ATH for short blocks. */
  int
  lame_set_ATHshort(int ATHshort)
  {
      if (is_lame_global_flags_valid()) {
          this.ATHshort = ATHshort;
          return 0;
      }
      return -1;
  }

  int
  lame_get_ATHshort()
  {
      if (is_lame_global_flags_valid()) {
          return this.ATHshort;
      }
      return 0;
  }


  /* Disable ATH. */
  int
  lame_set_noATH(int noATH)
  {
      if (is_lame_global_flags_valid()) {
          this.noATH = noATH;
          return 0;
      }
      return -1;
  }

  int
  lame_get_noATH()
  {
      if (is_lame_global_flags_valid()) {
          return this.noATH;
      }
      return 0;
  }


  /* Select ATH formula. */
  int
  lame_set_ATHtype(int ATHtype)
  {
      if (is_lame_global_flags_valid()) {
          /* XXX: ATHtype should be converted to an enum. */
          this.ATHtype = ATHtype;
          return 0;
      }
      return -1;
  }

  int
  lame_get_ATHtype()
  {
      if (is_lame_global_flags_valid()) {
          return this.ATHtype;
      }
      return 0;
  }


  /* Select ATH formula 4 shape. */
  int
  lame_set_ATHcurve(float ATHcurve)
  {
      if (is_lame_global_flags_valid()) {
          this.ATHcurve = ATHcurve;
          return 0;
      }
      return -1;
  }

  float
  lame_get_ATHcurve()
  {
      if (is_lame_global_flags_valid()) {
          return this.ATHcurve;
      }
      return 0;
  }


  /* Lower ATH by this many db. */
  int
  lame_set_ATHlower(float ATHlower)
  {
      if (is_lame_global_flags_valid()) {
          this.ATH_lower_db = ATHlower;
          return 0;
      }
      return -1;
  }

  float
  lame_get_ATHlower()
  {
      if (is_lame_global_flags_valid()) {
          return this.ATH_lower_db;
      }
      return 0;
  }


  /* Select ATH adaptive adjustment scheme. */
  int
  lame_set_athaa_type(int athaa_type)
  {
      if (is_lame_global_flags_valid()) {
          this.athaa_type = athaa_type;
          return 0;
      }
      return -1;
  }

  int
  lame_get_athaa_type()
  {
      if (is_lame_global_flags_valid()) {
          return this.athaa_type;
      }
      return 0;
  }


//  #if DEPRECATED_OR_OBSOLETE_CODE_REMOVED
//  int CDECL lame_set_athaa_loudapprox(int athaa_loudapprox);
//  int CDECL lame_get_athaa_loudapprox();
//  #else
//  #endif

  /* Select the loudness approximation used by the ATH adaptive auto-leveling. */
  int
  lame_set_athaa_loudapprox(int athaa_loudapprox)
  {
      (void) gfp;
      (void) athaa_loudapprox;
      return 0;
  }

  int
  lame_get_athaa_loudapprox()
  {
      (void) gfp;
      /* obsolete, the type known under number 2 is the only survival */
      return 2;
  }


  /* Adjust (in dB) the point below which adaptive ATH level adjustment occurs. */
  int
  lame_set_athaa_sensitivity(float athaa_sensitivity)
  {
      if (is_lame_global_flags_valid()) {
          this.athaa_sensitivity = athaa_sensitivity;
          return 0;
      }
      return -1;
  }

  float
  lame_get_athaa_sensitivity()
  {
      if (is_lame_global_flags_valid()) {
          return this.athaa_sensitivity;
      }
      return 0;
  }


  /* Predictability limit (ISO tonality formula) */
  int     lame_set_cwlimit(int cwlimit);
  int     lame_get_cwlimit();

  int
  lame_set_cwlimit(int cwlimit)
  {
      (void) gfp;
      (void) cwlimit;
      return 0;
  }

  int
  lame_get_cwlimit()
  {
      (void) gfp;
      return 0;
  }



  /*
   * Allow blocktypes to differ between channels.
   * default:
   *  0 for jstereo => block types coupled
   *  1 for stereo  => block types may differ
   */
  int
  lame_set_allow_diff_short(int allow_diff_short)
  {
      if (is_lame_global_flags_valid()) {
          this.short_blocks = allow_diff_short ? short_block_allowed : short_block_coupled;
          return 0;
      }
      return -1;
  }

  int
  lame_get_allow_diff_short()
  {
      if (is_lame_global_flags_valid()) {
          if (this.short_blocks == short_block_allowed)
              return 1;   /* short blocks allowed to differ */
          else
              return 0;   /* not set, dispensed, forced or coupled */
      }
      return 0;
  }


  /* Use temporal masking effect */
  int
  lame_set_useTemporal(int useTemporal)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 1 (enabled) */

          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (0 <= useTemporal && useTemporal <= 1) {
              this.useTemporal = useTemporal;
              return 0;
          }
      }
      return -1;
  }

  int
  lame_get_useTemporal()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.useTemporal && 1 >= this.useTemporal);
          return this.useTemporal;
      }
      return 0;
  }


  /* Use inter-channel masking effect */
  int
  lame_set_interChRatio(float ratio)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 0.0 (no inter-channel maskin) */
          if (0 <= ratio && ratio <= 1.0) {
              this.interChRatio = ratio;
              return 0;
          }
      }
      return -1;
  }

  float
  lame_get_interChRatio()
  {
      if (is_lame_global_flags_valid()) {
          assert((0 <= this.interChRatio && this.interChRatio <= 1.0) || EQ(this.interChRatio, -1));
          return this.interChRatio;
      }
      return 0;
  }


  /* Use pseudo substep shaping method */
  int
  lame_set_substep(int method)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 0.0 (no substep noise shaping) */
          if (0 <= method && method <= 7) {
              this.substep_shaping = method;
              return 0;
          }
      }
      return -1;
  }

  int
  lame_get_substep()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.substep_shaping && this.substep_shaping <= 7);
          return this.substep_shaping;
      }
      return 0;
  }

  /* scalefactors scale */
  int
  lame_set_sfscale(int val)
  {
      if (is_lame_global_flags_valid()) {
          this.noise_shaping = (val != 0) ? 2 : 1;
          return 0;
      }
      return -1;
  }

  int
  lame_get_sfscale()
  {
      if (is_lame_global_flags_valid()) {
          return (this.noise_shaping == 2) ? 1 : 0;
      }
      return 0;
  }

  /* subblock gain */
  int
  lame_set_subblock_gain(int sbgain)
  {
      if (is_lame_global_flags_valid()) {
          this.subblock_gain = sbgain;
          return 0;
      }
      return -1;
  }

  int
  lame_get_subblock_gain()
  {
      if (is_lame_global_flags_valid()) {
          return this.subblock_gain;
      }
      return 0;
  }


  /* Disable short blocks. */
  int
  lame_set_no_short_blocks(int no_short_blocks)
  {
      if (is_lame_global_flags_valid()) {
          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (0 <= no_short_blocks && no_short_blocks <= 1) {
              this.short_blocks = no_short_blocks ? short_block_dispensed : short_block_allowed;
              return 0;
          }
      }
      return -1;
  }

  int
  lame_get_no_short_blocks()
  {
      if (is_lame_global_flags_valid()) {
          switch (this.short_blocks) {
          default:
          case short_block_not_set:
              return -1;
          case short_block_dispensed:
              return 1;
          case short_block_allowed:
          case short_block_coupled:
          case short_block_forced:
              return 0;
          }
      }
      return -1;
  }


  /* Force short blocks. */
  int
  lame_set_force_short_blocks(int short_blocks)
  {
      if (is_lame_global_flags_valid()) {
          /* enforce disable/enable meaning, if we need more than two values
             we need to switch to an enum to have an apropriate representation
             of the possible meanings of the value */
          if (0 > short_blocks || 1 < short_blocks)
              return -1;

          if (short_blocks == 1)
              this.short_blocks = short_block_forced;
          else if (this.short_blocks == short_block_forced)
              this.short_blocks = short_block_allowed;

          return 0;
      }
      return -1;
  }

  int
  lame_get_force_short_blocks()
  {
      if (is_lame_global_flags_valid()) {
          switch (this.short_blocks) {
          default:
          case short_block_not_set:
              return -1;
          case short_block_dispensed:
          case short_block_allowed:
          case short_block_coupled:
              return 0;
          case short_block_forced:
              return 1;
          }
      }
      return -1;
  }

  int
  lame_set_short_threshold_lrm(float lrm)
  {
      if (is_lame_global_flags_valid()) {
          this.attackthre = lrm;
          return 0;
      }
      return -1;
  }

  float
  lame_get_short_threshold_lrm()
  {
      if (is_lame_global_flags_valid()) {
          return this.attackthre;
      }
      return 0;
  }

  int
  lame_set_short_threshold_s(float s)
  {
      if (is_lame_global_flags_valid()) {
          this.attackthre_s = s;
          return 0;
      }
      return -1;
  }

  float
  lame_get_short_threshold_s()
  {
      if (is_lame_global_flags_valid()) {
          return this.attackthre_s;
      }
      return 0;
  }

  int
  lame_set_short_threshold(float lrm, float s)
  {
      if (is_lame_global_flags_valid()) {
          lame_set_short_threshold_lrm(gfp, lrm);
          lame_set_short_threshold_s(gfp, s);
          return 0;
      }
      return -1;
  }


  /*
   * Input PCM is emphased PCM
   * (for instance from one of the rarely emphased CDs).
   *
   * It is STRONGLY not recommended to use this, because psycho does not
   * take it into account, and last but not least many decoders
   * ignore these bits
   */
  int
  lame_set_emphasis(int emphasis)
  {
      if (is_lame_global_flags_valid()) {
          /* XXX: emphasis should be converted to an enum */
          if (0 <= emphasis && emphasis < 4) {
              this.emphasis = emphasis;
              return 0;
          }
      }
      return -1;
  }

  int
  lame_get_emphasis()
  {
      if (is_lame_global_flags_valid()) {
          assert(0 <= this.emphasis && this.emphasis < 4);
          return this.emphasis;
      }
      return 0;
  }




  /***************************************************************/
  /* internal variables, cannot be set...                        */
  /* provided because they may be of use to calling application  */
  /***************************************************************/

  /* MPEG version.
   *  0 = MPEG-2
   *  1 = MPEG-1
   * (2 = MPEG-2.5)
   */
  int
  lame_get_version()
  {
      if (is_lame_global_flags_valid()) {
          final lame_internal_flags gfc = this.internal_flags;
          if (is_lame_internal_flags_valid(gfc) != 0) {
              return gfc.cfg.version;
          }
      }
      return 0;
  }


  /* Encoder delay. */
  int
  lame_get_encoder_delay()
  {
      if (is_lame_global_flags_valid()) {
          final lame_internal_flags gfc = this.internal_flags;
          if (is_lame_internal_flags_valid(gfc) != 0) {
              return gfc.ov_enc.encoder_delay;
          }
      }
      return 0;
  }

  /* padding added to the end of the input */
  int
  lame_get_encoder_padding()
  {
      if (is_lame_global_flags_valid()) {
          final lame_internal_flags gfc = this.internal_flags;
          if (is_lame_internal_flags_valid(gfc) != 0) {
              return gfc.ov_enc.encoder_padding;
          }
      }
      return 0;
  }


  /* Size of MPEG frame. */
  int
  lame_get_framesize()
  {
      if (is_lame_global_flags_valid()) {
          final lame_internal_flags gfc = this.internal_flags;
          if (is_lame_internal_flags_valid(gfc) != 0) {
              SessionConfig_t cfg = gfc.cfg;
              return 576 * cfg.mode_gr;
          }
      }
      return 0;
  }


  /* Number of frames encoded so far. */
  int
  lame_get_frameNum()
  {
      if (is_lame_global_flags_valid()) {
          final lame_internal_flags gfc = this.internal_flags;
          if (is_lame_internal_flags_valid(gfc)) {
              return gfc.ov_enc.frame_number;
          }
      }
      return 0;
  }

  int
  lame_get_mf_samples_to_encode()
  {
      if (is_lame_global_flags_valid()) {
        final lame_internal_flags gfc = this.internal_flags;
          if (is_lame_internal_flags_valid(gfc)) {
              return gfc.sv_enc.mf_samples_to_encode;
          }
      }
      return 0;
  }

  int
  lame_get_size_mp3buffer()
  {
      if (is_lame_global_flags_valid()) {
        final lame_internal_flags gfc = this.internal_flags;
          if (is_lame_internal_flags_valid(gfc)) {
              int     size;
              compute_flushbits(gfc, &size);
              return size;
          }
      }
      return 0;
  }

  int
  lame_get_RadioGain()
  {
      if (is_lame_global_flags_valid()) {
        final lame_internal_flags gfc = this.internal_flags;
          if (is_lame_internal_flags_valid(gfc)) {
              return gfc.ov_rpg.RadioGain;
          }
      }
      return 0;
  }

  int
  lame_get_AudiophileGain()
  {
      if (is_lame_global_flags_valid()) {
        final lame_internal_flags gfc = this.internal_flags;
          if (is_lame_internal_flags_valid(gfc)) {
              return 0;
          }
      }
      return 0;
  }

  float
  lame_get_PeakSample()
  {
      if (is_lame_global_flags_valid()) {
        final lame_internal_flags gfc = this.internal_flags;
          if (is_lame_internal_flags_valid(gfc)) {
              return (float) gfc.ov_rpg.PeakSample;
          }
      }
      return 0;
  }

  int
  lame_get_noclipGainChange()
  {
      if (is_lame_global_flags_valid()) {
        final lame_internal_flags gfc = this.internal_flags;
          if (is_lame_internal_flags_valid(gfc)) {
              return gfc.ov_rpg.noclipGainChange;
          }
      }
      return 0;
  }

  float
  lame_get_noclipScale()
  {
      if (is_lame_global_flags_valid()) {
        final lame_internal_flags gfc = this.internal_flags;
          if (is_lame_internal_flags_valid(gfc)) {
              return gfc.ov_rpg.noclipScale;
          }
      }
      return 0;
  }

static const UNSIGNED_LONG_MAX = 4294967295;

  /*
   * LAME's estimate of the total number of frames to be encoded.
   * Only valid if calling program set num_samples.
   */
  int
  lame_get_totalframes()
  {
      if (is_lame_global_flags_valid()) {
          final lame_internal_flags gfc = this.internal_flags;
          if (is_lame_internal_flags_valid(gfc) != 0) {
              final SessionConfig_t cfg = gfc.cfg;
              final int pcm_samples_per_frame = 576 * cfg.mode_gr;
              final int pcm_samples_to_encode = this.num_samples;
              const int end_padding = 0;

              /* estimate based on user set num_samples: */
              if (pcm_samples_to_encode == UNSIGNED_LONG_MAX) {
                  return 0;
              }
              if (this.samplerate_in != this.samplerate_out && this.samplerate_in > 0) {
                  final double q = (this.samplerate_out / this.samplerate_in).toDouble();
                  pcm_samples_to_encode *= q;
              }
              pcm_samples_to_encode += 576;
              end_padding = pcm_samples_per_frame - (pcm_samples_to_encode % pcm_samples_per_frame);
              if (end_padding < 576) {
                  end_padding += pcm_samples_per_frame;
              }
              pcm_samples_to_encode += end_padding;
              /* check to see if we underestimated totalframes */
              /*    if (totalframes < this.frameNum) */
              /*        totalframes = this.frameNum; */
              return pcm_samples_to_encode ~/ pcm_samples_per_frame;
          }
      }
      return 0;
  }





  int
  lame_set_preset(int preset)
  {
      if (is_lame_global_flags_valid()) {
          this.preset = preset;
          return apply_preset(gfp, preset, 1);
      }
      return -1;
  }



  int
  lame_set_asm_optimizations(int optim, int mode)
  {
      if (is_lame_global_flags_valid()) {
          mode = (mode == 1 ? 1 : 0);
          switch (optim) {
          case MMX:{
                  this.asm_optimizations.mmx = mode;
                  return optim;
              }
          case AMD_3DNOW:{
                  this.asm_optimizations.amd3dnow = mode;
                  return optim;
              }
          case SSE:{
                  this.asm_optimizations.sse = mode;
                  return optim;
              }
          default:
              return optim;
          }
      }
      return -1;
  }


  void
  lame_set_write_id3tag_automatic(int v)
  {
      if (is_lame_global_flags_valid()) {
          this.write_id3tag_automatic = v;
      }
  }


  int
  lame_get_write_id3tag_automatic()
  {
      if (is_lame_global_flags_valid()) {
          return this.write_id3tag_automatic;
      }
      return 1;
  }


  /*

  UNDOCUMENTED, experimental settings.  These routines are not prototyped
  in lame.h.  You should not use them, they are experimental and may
  change.

  */


  /*
   *  just another daily changing developer switch
   */
//  void CDECL lame_set_tune(lame_global_flags *, float);

  void
  lame_set_tune(double val)
  {
      if (is_lame_global_flags_valid()) {
          this.tune_value_a = val;
          this.tune = 1;
      }
  }

  /* Custom msfix hack */
  void
  lame_set_msfix(double msfix)
  {
      if (is_lame_global_flags_valid()) {
          /* default = 0 */
          this.msfix = msfix;
      }
  }

  double
  lame_get_msfix()
  {
      if (is_lame_global_flags_valid()) {
          return this.msfix;
      }
      return 0.0;
  }

//  #if DEPRECATED_OR_OBSOLETE_CODE_REMOVED
//  int CDECL lame_set_preset_expopts(lame_global_flags *, int);
//  #else
//  #endif

  int
  lame_set_preset_expopts(int preset_expopts)
  {
//      (void) gfp;
//      (void) preset_expopts;
      return 0;
  }


  int
  lame_set_preset_notune(int preset_notune)
  {
//      (void) gfp;
//      (void) preset_notune;
      return 0;
  }
}

