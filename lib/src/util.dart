/*
 *	lame utility library source file
 *
 *	Copyright (c) 1999 Albert L Faber
 *	Copyright (c) 2000-2005 Alexander Leidinger
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

/* $Id: util.c,v 1.154.2.1 2012/01/08 23:49:58 robert Exp $ */

//#ifdef HAVE_CONFIG_H
//# include <config.h>
//#endif
//
//#include "lame.h"
//#include "machine.h"
//#include "encoder.h"
//#include "util.h"
//#include "tables.h"
//
//#define PRECOMPUTE
//#if defined(__FreeBSD__) && !defined(__alpha__)
//# include <machine/floatingpoint.h>
//#endif


/*
 *      lame utility library include file
 *
 *      Copyright (c) 1999 Albert L Faber
 *      Copyright (c) 2008 Robert Hegemann
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

part of libmp3lame;

//#ifndef LAME_UTIL_H
//#define LAME_UTIL_H
//
//#include "l3side.h"
//#include "id3tag.h"
//#include "lame_global_flags.h"
//
//#ifdef __cplusplus
//extern  "C" {
//#endif

/***********************************************************************
*
*  Global Definitions
*
***********************************************************************/

//#ifndef FALSE
//#define         FALSE                   0
//#endif
//
//#ifndef TRUE
//#define         TRUE                    (!FALSE)
//#endif

//#ifdef UINT_MAX
//# define         MAX_U_32_NUM            UINT_MAX
//#else
const         MAX_U_32_NUM =           0xFFFFFFFF;
//#endif

//#ifndef PI
//# ifdef M_PI
//#  define       PI                      M_PI
//# else
const       PI      =                3.14159265358979323846;
//# endif
//#endif


//#ifdef M_LN2
//# define        LOG2                    M_LN2
//#else
const         LOG2         =           0.69314718055994530942;
//#endif

//#ifdef M_LN10
//# define        LOG10                   M_LN10
//#else
const      LOG10    =               2.30258509299404568402;
//#endif


//#ifdef M_SQRT2
//# define        SQRT2                   M_SQRT2
//#else
const       SQRT2   =                1.41421356237309504880;
//#endif


const        CRC16_POLYNOMIAL =       0x8005;

const MAX_BITS_PER_CHANNEL= 4095;
const MAX_BITS_PER_GRANULE= 7680;

/* "bit_stream.h" Definitions */
const         BUFFER_SIZE  =   LAME_MAXMP3BUFFER;

Min(A, B) =>       ((A) < (B) ? (A) : (B));
Max(A, B) =>      ((A) > (B) ? (A) : (B));

/* log/log10 approximations */
//#ifdef USE_FAST_LOG
FAST_LOG10(x)  =>     (fast_log2(x)*(LOG2/LOG10));
FAST_LOG(x)    =>     (fast_log2(x)*LOG2);
FAST_LOG10_X(x,y) =>  (fast_log2(x)*(LOG2/LOG10*(y)));
FAST_LOG_X(x,y)=>     (fast_log2(x)*(LOG2*(y)));
//#else
//#define         FAST_LOG10(x)       log10(x)
//#define         FAST_LOG(x)         log(x)
//#define         FAST_LOG10_X(x,y)   (log10(x)*(y))
//#define         FAST_LOG_X(x,y)     (log(x)*(y))
//#endif


//    struct replaygain_data;
//#ifndef replaygain_data_defined
//#define replaygain_data_defined
//    typedef struct replaygain_data replaygain_t;
//#endif
//    struct plotting_data;
//#ifndef plotting_data_defined
//#define plotting_data_defined
//    typedef struct plotting_data plotting_data;
//#endif

/***********************************************************************
*
*  Global Type Definitions
*
***********************************************************************/

//    typedef struct {
//        void   *aligned;     /* pointer to ie. 128 bit aligned memory */
//        void   *pointer;     /* to use with malloc/free */
//    } aligned_pointer_t;

//    void    malloc_aligned(aligned_pointer_t * ptr, unsigned int size, unsigned int bytes);
//    void    free_aligned(aligned_pointer_t * ptr);


//    typedef void (*iteration_loop_t) (lame_internal_flags * gfc, const FLOAT pe[2][2],
//                                      const FLOAT ms_ratio[2], const III_psy_ratio ratio[2][2]);
//

    /* "bit_stream.h" Type Definitions */

    class bit_stream_struc {
        typed.Uint8List buf;  /* bit stream buffer */
        int     buf_size;    /* size of buffer (in number of bytes) */
        int     totbit;      /* bit counter of bit stream */
        int     buf_byte_idx; /* pointer to top byte in buffer */
        int     buf_bit_idx; /* pointer to top bit of top byte in buffer */

        /* format of file in rd mode (BINARY/ASCII) */
    }



    class VBR_seek_info_t {
        int     sum;         /* what we have seen so far */
        int     seen;        /* how many frames we have seen in this chunk */
        int     want;        /* how many frames we want to collect into one chunk */
        int     pos;         /* actual position in our bag */
        int     size;        /* size of our bag */
        List<int>    bag;         /* pointer to our bag */
        int nVbrNumFrames;
        int nBytesWritten;
        /* VBR tag data */
        int TotalFrameSize;
    }


    /**
     *  ATH related stuff, if something new ATH related has to be added,
     *  please plugg it here into the ATH_t struct
     */
    class ATH_t {
        int     use_adjust;  /* method for the auto adjustment  */
        double   aa_sensitivity_p; /* factor for tuning the (sample power)
                                     point below which adaptive threshold
                                     of hearing adjustment occurs */
        double   adjust_factor; /* lowering based on peak volume, 1 = no lowering */
        double   adjust_limit; /* limit for dynamic ATH adjust */
        double   decay;       /* determined to lower x dB each second */
        double   floor;       /* lowest ATH value */
        var   l = new List<double>(SBMAX_l);  /* ATH for sfbs in long blocks */
        var   s = new List<double>(SBMAX_s);  /* ATH for sfbs in short blocks */
        var   psfb21 = new List<double>(PSFB21); /* ATH for partitionned sfb21 in long blocks */
        var   psfb12 = new List<double>(PSFB12); /* ATH for partitionned sfb12 in short blocks */
        var   cb_l = new List<double>(CBANDS); /* ATH for long block convolution bands */
        var   cb_s = new List<double>(CBANDS); /* ATH for short block convolution bands */
        var   eql_w = new List<double>(BLKSIZE ~/ 2); /* equal loudness weights (based on ATH) */
    }

    /**
     *  PSY Model related stuff
     */

    class PsyConst_CB2SB_t {
        var     masking_lower = new List<double>(CBANDS);
        var     minval = new List<double>(CBANDS);
        var     rnumlines = new List<double>(CBANDS);
        var     mld_cb = new List<double>(CBANDS);
        var     mld = new List<double>(Max(SBMAX_l,SBMAX_s));
        var     bo_weight = new List<double>(Max(SBMAX_l,SBMAX_s)); /* band weight long scalefactor bands, at transition */
        double  attack_threshold; /* short block tuning */
        int     s3ind[CBANDS][2];
        var     numlines = new List<int>(CBANDS);
        var     bm = new List<int>(Max(SBMAX_l,SBMAX_s));
        var     bo = new List<int>(Max(SBMAX_l,SBMAX_s));
        int     npart;
        int     n_sb; /* SBMAX_l or SBMAX_s */
        List<double>  s3;
    }


    /**
     *  global data constants
     */
    class PsyConst_t {
        PsyConst_CB2SB_t l;
        PsyConst_CB2SB_t s;
        PsyConst_CB2SB_t l_to_s;
        var     attack_threshold = new List<double>(4);
        double  decay;
        int     force_short_block_calc;
    }


    class PsyStateVar_t {

        FLOAT   nb_l1[4][CBANDS], nb_l2[4][CBANDS];
        FLOAT   nb_s1[4][CBANDS], nb_s2[4][CBANDS];

        III_psy_xmin thm[4];
        III_psy_xmin en[4];

        /* loudness calculation (for adaptive threshold of hearing) */
        FLOAT   loudness_sq_save[2]; /* account for granule delay of L3psycho_anal */

        FLOAT   tot_ener[4];

        FLOAT   last_en_subshort[4][9];
        int     last_attacks[4];

        int     blocktype_old[2];
    }


    class PsyResult_t {
        /* loudness calculation (for adaptive threshold of hearing) */
        var   loudness_sq = [[0.0, 0.0], [0.0, 0.0]]; /* loudness^2 approx. per granule and channel */
    }


    class header_t {
                int     write_timing;
                int     ptr;
                var    buf = typed.Uint8List(MAX_HEADER_LEN);
            }

    /* variables used by encoder.c */
    class EncStateVar_t {
        /* variables for newmdct.c */
        List<List<List<List<double>>>>   sb_sample = listND([2,2,18,SBLIMIT]);//[2][2][18][SBLIMIT];
        var   amp_filter = new List<double>(32);

        /* variables used by util.c */
        /* BPC = maximum number of filter convolution windows to precompute */
 static const BPC = 320;
        var  itime = [0.0, 0.0]; /* float precision seems to be not enough */
        List<typed.Float32List> inbuf_old = [null, null];
        List<typed.Float32List> blackfilt = new List<typed.Float32List>.filled(2 * BPC + 1, null);

        var   pefirbuf = new List<double>(19);

        /* used for padding */
        int     frac_SpF;
        int     slot_lag;

        /* variables for bitstream.c */
        /* mpeg1: buffer=511 bytes  smallest frame: 96-38(sideinfo)=58
         * max number of frames in reservoir:  8
         * mpeg2: buffer=255 bytes.  smallest frame: 24-23bytes=1
         * with VBR, if you are encoding all silence, it is possible to
         * have 8kbs/24khz frames with 1byte of data each, which means we need
         * to buffer up to 255 headers! */
        /* also, max_header_buf has to be a power of two */
static const MAX_HEADER_BUF = 256;
static const MAX_HEADER_LEN = 40 ;   /* max size of header is 38 */

        var header = new List<header_t>(MAX_HEADER_BUF);

        int     h_ptr;
        int     w_ptr;
        int     ancillary_flag;

        /* variables for reservoir.c */
        int     ResvSize;    /* in bits */
        int     ResvMax;     /* in bits */

        int     in_buffer_nsamples;
        typed.Float32List in_buffer_0;
        typed.Float32List in_buffer_1;

//#ifndef  MFSIZE
static const MFSIZE = ( 3*1152 + ENCDELAY - MDCTDELAY );
//#endif
        var mfbuf = [new typed.Float32List(MFSIZE), new typed.Float32List(MFSIZE)];

        int     mf_samples_to_encode;
        int     mf_size;

    }

    class EncResult_t {
        /* simple statistics */
        List    bitrate_channelmode_hist = listND([16, 4 + 1]); //[16][4 + 1];
        List    bitrate_blocktype_hist = listND([16, 4 + 1 + 1]); //[16][4 + 1 + 1]; /*norm/start/short/stop/mixed(short)/sum */

        int     bitrate_index;
        int     frame_number; /* number of frames encoded             */
        bool    padding;     /* padding for the current frame? */
        int     mode_ext;
        int     encoder_delay;
        int     encoder_padding; /* number of samples of padding appended to input */
    }


    /* variables used by quantize.c */
    class QntStateVar_t {
        /* variables for nspsytune */
        var   longfact = new List<double>(SBMAX_l);
        var   shortfact = new List<double>(SBMAX_s);
        double   masking_lower;
        double   mask_adjust; /* the dbQ stuff */
        double   mask_adjust_short; /* the dbQ stuff */
        var     OldValue = new List<int>(2);
        var     CurrentStep = new List<int>(2);
        var     pseudohalf = new List<int>(SFBMAX);
        int     sfb21_extra; /* will be set in lame_init_params */
        int     substep_shaping; /* 0 = no substep
                                    1 = use substep shaping at last step(VBR only)
                                    (not implemented yet)
                                    2 = use substep inside loop
                                    3 = use substep inside loop and last step
                                  */


        var    bv_scf = new typed.Int8List(576);
    }


    class RpgStateVar_t {
        replaygain_t rgdata;
        /* ReplayGain */
    }


    class RpgResult_t {
        double  noclipScale; /* user-specified scale factor required for preventing clipping */
        double  PeakSample;
        int     RadioGain;
        int     noclipGainChange; /* gain change required for preventing clipping */
    }


    class SessionConfig_t {
        int     version;     /* 0=MPEG-2/2.5  1=MPEG-1               */
        int     samplerate_index;
        int     sideinfo_len;

        int     noise_shaping; /* 0 = none
                                  1 = ISO AAC model
                                  2 = allow scalefac_select=1
                                */

        int     subblock_gain; /*  0 = no, 1 = yes */
        int     use_best_huffman; /* 0 = no.  1=outside loop  2=inside loop(slow) */
        int     noise_shaping_amp; /*  0 = ISO model: amplify all distorted bands
                                      1 = amplify within 50% of max (on db scale)
                                      2 = amplify only most distorted band
                                      3 = method 1 and refine with method 2
                                    */

        int     noise_shaping_stop; /* 0 = stop at over=0, all scalefacs amplified or
                                       a scalefac has reached max value
                                       1 = stop when all scalefacs amplified or
                                       a scalefac has reached max value
                                       2 = stop when all scalefacs amplified
                                     */


        int     full_outer_loop; /* 0 = stop early after 0 distortion found. 1 = full search */

        int     lowpassfreq;
        int     highpassfreq;
        int     samplerate_in; /* input_samp_rate in Hz. default=44.1 kHz     */
        int     samplerate_out; /* output_samp_rate. */
        int     channels_in; /* number of channels in the input data stream (PCM or decoded PCM) */
        int     channels_out; /* number of channels in the output data stream (not used for decoding) */
        int     mode_gr;     /* granules per frame */
        int     force_ms;    /* force M/S mode.  requires mode=1            */

        int     quant_comp;
        int     quant_comp_short;

        int     use_temporal_masking_effect;
        int     use_safe_joint_stereo;

        int     preset;

        vbr_mode vbr;
        int     vbr_avg_bitrate_kbps;
        int     vbr_min_bitrate_index; /* min bitrate index */
        int     vbr_max_bitrate_index; /* max bitrate index */
        int     avg_bitrate;
        int     enforce_min_bitrate; /* strictly enforce VBR_min_bitrate normaly, it will be violated for analog silence */

        int     findReplayGain; /* find the RG value? default=0       */
        int     findPeakSample;
        int     decode_on_the_fly; /* decode on the fly? default=0                */
        int     analysis;
        int     disable_reservoir;
        int     buffer_constraint;  /* enforce ISO spec as much as possible   */
        int     free_format;
        int     write_lame_tag; /* add Xing VBR tag?                           */

        int     error_protection; /* use 2 bytes per frame for a CRC checksum. default=0 */
        int     copyright;   /* mark as copyright. default=0           */
        int     original;    /* mark as original. default=1            */
        int     extension;   /* the MP3 'private extension' bit. Meaningless */
        int     emphasis;    /* Input PCM is emphased PCM (for
                                instance from one of the rarely
                                emphased CDs), it is STRONGLY not
                                recommended to use this, because
                                psycho does not take it into account,
                                and last but not least many decoders
                                don't care about these bits          */


        MPEG_mode mode;
        short_block_t short_blocks;

        double   interChRatio;
        double   msfix;       /* Naoki's adjustment of Mid/Side maskings */
        double   ATH_offset_db;/* add to ATH this many db            */
        double   ATH_offset_factor;/* change ATH by this factor, derived from ATH_offset_db */
        double   ATHcurve;    /* change ATH formula 4 shape           */
        int     ATHtype;
        int     ATHonly;     /* only use ATH                         */
        int     ATHshort;    /* only use ATH for short blocks        */
        int     noATH;       /* disable ATH                          */

        double   ATHfixpoint;

        double   adjust_alto_db;
        double   adjust_bass_db;
        double   adjust_treble_db;
        double   adjust_sfb21_db;

        double   compression_ratio; /* sizeof(wav file)/sizeof(mp3 file)          */

        /* lowpass and highpass filter control */
        double   lowpass1, lowpass2; /* normalized frequency bounds of passband */
        double   highpass1, highpass2; /* normalized frequency bounds of passband */

        /* scale input by this amount before encoding at least not used for MP3 decoding */
        var   pcm_transform = [ [0.0, 0.0], [0.0, 0.0] ];

        double   minval;
    }


    class lame_internal_flags {

  /********************************************************************
   * internal variables NOT set by calling program, and should not be *
   * modified by the calling program                                  *
   ********************************************************************/

        /*
         * Some remarks to the Class_ID field:
         * The Class ID is an Identifier for a pointer to this struct.
         * It is very unlikely that a pointer to lame_global_flags has the same 32 bits
         * in it's structure (large and other special properties, for instance prime).
         *
         * To test that the structure is right and initialized, use:
         *     if ( gfc -> Class_ID == LAME_ID ) ...
         * Other remark:
         *     If you set a flag to 0 for uninit data and 1 for init data, the right test
         *     should be "if (flag == 1)" and NOT "if (flag)". Unintended modification
         *     of this element will be otherwise misinterpreted as an init.
         */
 static const  LAME_ID =  0xFFF88E3B;
        int class_id;

        int     lame_encode_frame_init;
        int     iteration_init_init;
        int     fill_buffer_resample_init;

        SessionConfig_t cfg;

        /* variables used by lame.c */
        Bit_stream_struc bs;
        III_side_info_t l3_side;

        scalefac_struct scalefac_band;

        PsyStateVar_t sv_psy; /* DATA FROM PSYMODEL.C */
        PsyResult_t ov_psy;
        EncStateVar_t sv_enc; /* DATA FROM ENCODER.C */
        EncResult_t ov_enc;
        QntStateVar_t sv_qnt; /* DATA FROM QUANTIZE.C */

        RpgStateVar_t sv_rpg;
        RpgResult_t ov_rpg;

        /* optional ID3 tags, used in id3tag.c  */
        id3tag_spec tag_spec;
        int nMusicCRC;

        int _unused;

        /* CPU features */
        CPU_features_t CPU_features;



        VBR_seek_info_t VBR_seek_table; /* used for Xing VBR header */

        ATH_t  ATH;         /* all ATH related stuff */

        PsyConst_t cd_psy;

        /* used by the frame analyzer */
        plotting_data pinfo;
        hip_t hip;

        iteration_loop_t iteration_loop;

        /* functions to replace with CPU feature optimized versions in takehiro.c */
        var choose_table;
        var fft_fht;
        var init_xrpow_core;
//        int     (*choose_table) (const int *ix, const int *const end, int *const s);
//        void    (*fft_fht) (FLOAT *, int);
//        void    (*init_xrpow_core) (gr_info * const cod_info, FLOAT xrpow[576], int upper,
//                                    FLOAT * sum);

        lame_report_function report_msg;
        lame_report_function report_dbg;
        lame_report_function report_err;
    }

    class CPU_features_t {
      int MMX;//:1; /* Pentium MMX, Pentium II...IV, K6, K6-2,
                           /*  K6-III, Athlon */
      int AMD_3DNow;//:1; /* K6-2, K6-III, Athlon      */
      int SSE;//:1; /* Pentium III, Pentium 4    */
      int SSE2;//:1; /* Pentium 4, K8             */
      int _unused;//:28;
  }

//#ifndef lame_internal_flags_defined
//#define lame_internal_flags_defined
//    typedef struct lame_internal_flags lame_internal_flags;
//#endif


/***********************************************************************
*
*  Global Function Prototype Declarations
*
***********************************************************************/
//    void    freegfc(lame_internal_flags * const gfc);
//    void    free_id3tag(lame_internal_flags * const gfc);
//    extern int BitrateIndex(int, int, int);
//    extern int FindNearestBitrate(int, int, int);
//    extern int map2MP3Frequency(int freq);
//    extern int SmpFrqIndex(int, int *const);
//    extern int nearestBitrateFullIndex(uint16_t brate);
//    extern FLOAT ATHformula(SessionConfig_t const *cfg, FLOAT freq);
//    extern FLOAT freq2bark(FLOAT freq);
//    void    disable_FPE(void);

/* log/log10 approximations */
//    extern void init_log_table(void);
//    extern ieee754_float32_t fast_log2(ieee754_float32_t x);
//
//    int     isResamplingNecessary(SessionConfig_t const* cfg);
//
//    void    fill_buffer(lame_internal_flags * gfc,
//                        sample_t *const mfbuf[2],
//                        sample_t const *const in_buffer[2], int nsamples, int *n_in, int *n_out);

/* same as lame_decode1 (look in lame.h), but returns
   unclipped raw floating-point samples. It is declared
   here, not in lame.h, because it returns LAME's
   internal type sample_t. No more than 1152 samples
   per channel are allowed. */
//    int     hip_decode1_unclipped(hip_t hip, unsigned char *mp3buf,
//                                   size_t len, sample_t pcm_l[], sample_t pcm_r[]);
//
//
//    extern int has_MMX(void);
//    extern int has_3DNow(void);
//    extern int has_SSE(void);
//    extern int has_SSE2(void);



/***********************************************************************
*
*  Macros about Message Printing and Exit
*
***********************************************************************/

//    extern void lame_report_def(const char* format, va_list args);
//    extern void lame_report_fnc(lame_report_function print_f, const char *, ...);
//    extern void lame_errorf(const lame_internal_flags * gfc, const char *, ...);
//    extern void lame_debugf(const lame_internal_flags * gfc, const char *, ...);
//    extern void lame_msgf(const lame_internal_flags * gfc, const char *, ...);
var DEBUGF =  lame_debugf;
var ERRORF =  lame_errorf;
var MSGF =    lame_msgf;

//    int     is_lame_internal_flags_valid(const lame_internal_flags * gfp);
//
//    extern void hip_set_pinfo(hip_t hip, plotting_data* pinfo);

//#ifdef __cplusplus
//}
//#endif
//#endif                       /* LAME_UTIL_H */



/***********************************************************************
*
*  Global Function Definitions
*
***********************************************************************/
/*empty and close mallocs in gfc */

void
free_id3tag(lame_internal_flags gfc)
{
    if (gfc.tag_spec.title != 0) {
        free(gfc.tag_spec.title);
        gfc.tag_spec.title = 0;
    }
    if (gfc.tag_spec.artist != 0) {
        free(gfc.tag_spec.artist);
        gfc.tag_spec.artist = 0;
    }
    if (gfc.tag_spec.album != 0) {
        free(gfc.tag_spec.album);
        gfc.tag_spec.album = 0;
    }
    if (gfc.tag_spec.comment != 0) {
        free(gfc.tag_spec.comment);
        gfc.tag_spec.comment = 0;
    }

    if (gfc.tag_spec.albumart != 0) {
        free(gfc.tag_spec.albumart);
        gfc.tag_spec.albumart = 0;
        gfc.tag_spec.albumart_size = 0;
        gfc.tag_spec.albumart_mimetype = MIMETYPE_NONE;
    }
    if (gfc.tag_spec.v2_head != 0) {
        FrameDataNode node = gfc.tag_spec.v2_head;
        do {
            var   p = node.dsc.ptr.b;
            var   q = node.txt.ptr.b;
            var   r = node;
            node = node.nxt;
//            free(p);
//            free(q);
//            free(r);
        } while (node != 0);
        gfc.tag_spec.v2_head = 0;
        gfc.tag_spec.v2_tail = 0;
    }
}


void
free_global_data(lame_internal_flags gfc)
{
    if (gfc != null && gfc.cd_psy != null) {
//        if (gfc.cd_psy.l.s3) {
//            /* XXX allocated in psymodel_init() */
//            free(gfc.cd_psy.l.s3);
//        }
//        if (gfc.cd_psy.s.s3) {
//            /* XXX allocated in psymodel_init() */
//            free(gfc.cd_psy.s.s3);
//        }
//        free(gfc.cd_psy);
        gfc.cd_psy = null;
    }
}


void
freegfc(lame_internal_flags gfc)
{                       /* bit stream structure */
    int     i;


    for (i = 0; i <= 2 * BPC; i++)
        if (gfc.sv_enc.blackfilt[i] != null) {
//            free(gfc.sv_enc.blackfilt[i]);
            gfc.sv_enc.blackfilt[i] = null;
        }
    if (gfc.sv_enc.inbuf_old[0]) {
//        free(gfc.sv_enc.inbuf_old[0]);
        gfc.sv_enc.inbuf_old[0] = null;
    }
    if (gfc.sv_enc.inbuf_old[1]) {
//        free(gfc.sv_enc.inbuf_old[1]);
        gfc.sv_enc.inbuf_old[1] = null;
    }

    if (gfc.bs.buf != null) {
//        free(gfc.bs.buf);
        gfc.bs.buf = null;
    }

    if (gfc.VBR_seek_table.bag) {
//        free(gfc.VBR_seek_table.bag);
        gfc.VBR_seek_table.bag = null;
        gfc.VBR_seek_table.size = 0;
    }
//    if (gfc.ATH) {
//        free(gfc.ATH);
//    }
//    if (gfc.sv_rpg.rgdata) {
//        free(gfc.sv_rpg.rgdata);
//    }
//    if (gfc.sv_enc.in_buffer_0) {
//        free(gfc.sv_enc.in_buffer_0);
//    }
//    if (gfc.sv_enc.in_buffer_1) {
//        free(gfc.sv_enc.in_buffer_1);
//    }
//    free_id3tag(gfc);

//#ifdef DECODE_ON_THE_FLY
//    if (gfc.hip) {
//        hip_decode_exit(gfc.hip);
//        gfc.hip = 0;
//    }
//#endif

    free_global_data(gfc);

//    free(gfc);
}

//void
//malloc_aligned(aligned_pointer_t * ptr, int size, int bytes)
//{
//    if (ptr) {
//        if (!ptr.pointer) {
//            ptr.pointer = malloc(size + bytes);
//            if (bytes > 0) {
//                ptr.aligned = (void *) ((((size_t) ptr.pointer + bytes - 1) / bytes) * bytes);
//            }
//            else {
//                ptr.aligned = ptr.pointer;
//            }
//        }
//    }
//}

//void
//free_aligned(aligned_pointer_t * ptr)
//{
//    if (ptr) {
//        if (ptr.pointer) {
//            free(ptr.pointer);
//            ptr.pointer = 0;
//            ptr.aligned = 0;
//        }
//    }
//}

/*those ATH formulas are returning
their minimum value for input = -1*/

num
ATHformula_GB(num f, num value, num f_min, num f_max)
{
    /* from Painter & Spanias
       modified by Gabriel Bouvigne to better fit the reality
       ath =    3.640 * pow(f,-0.8)
       - 6.800 * exp(-0.6*pow(f-3.4,2.0))
       + 6.000 * exp(-0.15*pow(f-8.7,2.0))
       + 0.6* 0.001 * pow(f,4.0);


       In the past LAME was using the Painter &Spanias formula.
       But we had some recurrent problems with HF content.
       We measured real ATH values, and found the older formula
       to be inacurate in the higher part. So we made this new
       formula and this solved most of HF problematic testcases.
       The tradeoff is that in VBR mode it increases a lot the
       bitrate. */


/*this curve can be udjusted according to the VBR scale:
it adjusts from something close to Painter & Spanias
on V9 up to Bouvigne's formula for V0. This way the VBR
bitrate is more balanced according to the -V value.*/

  num   ath;

    /* the following Hack allows to ask for the lowest value */
    if (f < -.3)
        f = 3410;

    f /= 1000;          /* convert to khz */
    f = Max(f_min, f);
    f = Min(f_max, f);

    ath = 3.640 * pow(f, -0.8)
        - 6.800 * exp(-0.6 * pow(f - 3.4, 2.0))
        + 6.000 * exp(-0.15 * pow(f - 8.7, 2.0))
        + (0.6 + 0.04 * value) * 0.001 * pow(f, 4.0);
    return ath;
}



num
ATHformula(SessionConfig_t cfg, num f)
{
  num   ath;
    switch (cfg.ATHtype) {
    case 0:
        ath = ATHformula_GB(f, 9, 0.1, 24.0);
        break;
    case 1:
        ath = ATHformula_GB(f, -1, 0.1, 24.0); /*over sensitive, should probably be removed */
        break;
    case 2:
        ath = ATHformula_GB(f, 0, 0.1, 24.0);
        break;
    case 3:
        ath = ATHformula_GB(f, 1, 0.1, 24.0) + 6; /*modification of GB formula by Roel */
        break;
    case 4:
        ath = ATHformula_GB(f, cfg.ATHcurve, 0.1, 24.0);
        break;
    case 5:
        ath = ATHformula_GB(f, cfg.ATHcurve, 3.41, 16.1);
        break;
    default:
        ath = ATHformula_GB(f, 0, 0.1, 24.0);
        break;
    }
    return ath;
}

/* see for example "Zwicker: Psychoakustik, 1982; ISBN 3-540-11401-7 */
double
freq2bark(double freq)
{
    /* input: freq in hz  output: barks */
    if (freq < 0)
        freq = 0;
    freq = freq * 0.001;
    return 13.0 * atan(.76 * freq) + 3.5 * atan(freq * freq / (7.5 * 7.5));
}

//#if 0
//extern FLOAT freq2cbw(FLOAT freq);
//
///* see for example "Zwicker: Psychoakustik, 1982; ISBN 3-540-11401-7 */
//FLOAT
//freq2cbw(FLOAT freq)
//{
//    /* input: freq in hz  output: critical band width */
//    freq = freq * 0.001;
//    return 25 + 75 * pow(1 + 1.4 * (freq * freq), 0.69);
//}
//
//#endif




ABS(A) => (((A)>0) ? (A) : -(A));

int
FindNearestBitrate(int bRate, /* legal rates from 8 to 320 */
                   int version, int samplerate)
{                       /* MPEG-1 or MPEG-2 LSF */
    int     bitrate;
    int     i;

    if (samplerate < 16000)
        version = 2;

    bitrate = bitrate_table[version][1];

    for (i = 2; i <= 14; i++) {
        if (bitrate_table[version][i] > 0) {
            if (ABS(bitrate_table[version][i] - bRate) < ABS(bitrate - bRate))
                bitrate = bitrate_table[version][i];
        }
    }
    return bitrate;
}





Min(A, B) => ((A) < (B) ? (A) : (B));
Max(A, B) => ((A) > (B) ? (A) : (B));



/* Used to find table index when
 * we need bitrate-based values
 * determined using tables
 *
 * bitrate in kbps
 *
 * Gabriel Bouvigne 2002-11-03
 */
int
nearestBitrateFullIndex(int bitrate)
{
    /* borrowed from DM abr presets */

    const full_bitrate_table = const
        [ 8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320 ];


    int     lower_range = 0, lower_range_kbps = 0, upper_range = 0, upper_range_kbps = 0;


    int     b;


    /* We assume specified bitrate will be 320kbps */
    upper_range_kbps = full_bitrate_table[16];
    upper_range = 16;
    lower_range_kbps = full_bitrate_table[16];
    lower_range = 16;

    /* Determine which significant bitrates the value specified falls between,
     * if loop ends without breaking then we were correct above that the value was 320
     */
    for (b = 0; b < 16; b++) {
        if ((Max(bitrate, full_bitrate_table[b + 1])) != bitrate) {
            upper_range_kbps = full_bitrate_table[b + 1];
            upper_range = b + 1;
            lower_range_kbps = full_bitrate_table[b];
            lower_range = (b);
            break;      /* We found upper range */
        }
    }

    /* Determine which range the value specified is closer to */
    if ((upper_range_kbps - bitrate) > (bitrate - lower_range_kbps)) {
        return lower_range;
    }
    return upper_range;
}





/* map frequency to a valid MP3 sample frequency
 *
 * Robert Hegemann 2000-07-01
 */
int
map2MP3Frequency(int freq)
{
    if (freq <= 8000)
        return 8000;
    if (freq <= 11025)
        return 11025;
    if (freq <= 12000)
        return 12000;
    if (freq <= 16000)
        return 16000;
    if (freq <= 22050)
        return 22050;
    if (freq <= 24000)
        return 24000;
    if (freq <= 32000)
        return 32000;
    if (freq <= 44100)
        return 44100;

    return 48000;
}

int
BitrateIndex(int bRate,      /* legal rates from 32 to 448 kbps */
             int version,    /* MPEG-1 or MPEG-2/2.5 LSF */
             int samplerate)
{                       /* convert bitrate in kbps to index */
    int     i;
    if (samplerate < 16000)
        version = 2;
    for (i = 0; i <= 14; i++) {
        if (bitrate_table[version][i] > 0) {
            if (bitrate_table[version][i] == bRate) {
                return i;
            }
        }
    }
    return -1;
}

/* convert samp freq in Hz to index */

List<int>
SmpFrqIndex(int sample_freq, int version)
{
    switch (sample_freq) {
    case 44100:
        version = 1;
        return [0,version];
    case 48000:
        version = 1;
        return [1,version];
    case 32000:
        version = 1;
        return [2,version];
    case 22050:
        version = 0;
        return [0,version];
    case 24000:
        version = 0;
        return [1,version];
    case 16000:
        version = 0;
        return [2,version];
    case 11025:
        version = 0;
        return [0,version];
    case 12000:
        version = 0;
        return [1,version];
    case 8000:
        version = 0;
        return [2,version];
    default:
        version = 0;
        return [-1,version];
    }
}


/*****************************************************************************
*
*  End of bit_stream.c package
*
*****************************************************************************/










/* resampling via FIR filter, blackman window */
double
blackman(double x, double fcn, int l)
{
    /* This algorithm from:
       SIGNAL PROCESSING ALGORITHMS IN FORTRAN AND C
       S.D. Stearns and R.A. David, Prentice-Hall, 1992
     */
    double   bkwn, x2;
    final double wcn = (PI * fcn);

    x /= l;
    if (x < 0)
        x = 0;
    if (x > 1)
        x = 1;
    x2 = x - .5;

    bkwn = 0.42 - 0.5 * cos(2 * x * PI) + 0.08 * cos(4 * x * PI);
    if (fabs(x2) < 1e-9)
        return wcn / PI;
    else
        return (bkwn * sin(l * wcn * x2) / (PI * l * x2));


}




/* gcd - greatest common divisor */
/* Joint work of Euclid and M. Hendry */

int
gcd(int i, int j)
{
    /*    assert ( i > 0  &&  j > 0 ); */
    return j ? gcd(j, i % j) : i;
}



int
fill_buffer_resample(lame_internal_flags gfc,
                     typed.Float32List outbuf,
                     int desired_len, typed.Float32List inbuf, int len, int /* * */ num_used, int ch)
{
    SessionConfig_t cfg = gfc.cfg;
    EncStateVar_t esv = gfc.sv_enc;
    double  resample_ratio = cfg.samplerate_in / cfg.samplerate_out;
    int     BLACKSIZE;
    double   offset, xvalue;
    int     i, j = 0, k;
    int     filter_l;
    double   fcn, intratio;
    typed.Float32List  inbuf_old;
    int     bpc;             /* number of convolution functions to pre-compute */
    bpc = cfg.samplerate_out / gcd(cfg.samplerate_out, cfg.samplerate_in);
    if (bpc > BPC)
        bpc = BPC;

    intratio = (fabs(resample_ratio - floor(.5 + resample_ratio)) < .0001);
    fcn = 1.00 / resample_ratio;
    if (fcn > 1.00)
        fcn = 1.00;
    filter_l = 31;     /* must be odd */
    filter_l += intratio; /* unless resample_ratio=int, it must be even */


    BLACKSIZE = filter_l + 1; /* size of data needed for FIR */

    if (gfc.fill_buffer_resample_init == 0) {
        esv.inbuf_old[0] = calloc(BLACKSIZE, sizeof(esv.inbuf_old[0][0]));
        esv.inbuf_old[1] = calloc(BLACKSIZE, sizeof(esv.inbuf_old[0][0]));
        for (i = 0; i <= 2 * bpc; ++i)
            esv.blackfilt[i] = calloc(BLACKSIZE, sizeof(esv.blackfilt[0][0]));

        esv.itime[0] = 0;
        esv.itime[1] = 0;

        /* precompute blackman filter coefficients */
        for (j = 0; j <= 2 * bpc; j++) {
            FLOAT   sum = 0.0;
            offset = (j - bpc) / (2.0 * bpc);
            for (i = 0; i <= filter_l; i++)
                sum += esv.blackfilt[j][i] = blackman(i - offset, fcn, filter_l);
            for (i = 0; i <= filter_l; i++)
                esv.blackfilt[j][i] /= sum;
        }
        gfc.fill_buffer_resample_init = 1;
    }

    inbuf_old = esv.inbuf_old[ch];

    /* time of j'th element in inbuf = itime + j/ifreq; */
    /* time of k'th element in outbuf   =  j/ofreq */
    for (k = 0; k < desired_len; k++) {
        double  time0 = k * resample_ratio; /* time of k'th output sample */
        int     joff;

        j = floor(time0 - esv.itime[ch]);

        /* check if we need more input data */
        if ((filter_l + j - filter_l / 2) >= len)
            break;

        /* blackman filter.  by default, window centered at j+.5(filter_l%2) */
        /* but we want a window centered at time0.   */
        offset = (time0 - esv.itime[ch] - (j + .5 * (filter_l % 2)));
        assert(fabs(offset) <= .501);

        /* find the closest precomputed window for this offset: */
        joff = floor((offset * 2 * bpc) + bpc + .5);

        xvalue = 0.0;
        for (i = 0; i <= filter_l; ++i) {
            final int j2 = i + j - filter_l / 2;
            sample_t y;
            assert(j2 < len);
            assert(j2 + BLACKSIZE >= 0);
            y = (j2 < 0) ? inbuf_old[BLACKSIZE + j2] : inbuf[j2];
#ifdef PRECOMPUTE
            xvalue += y * esv.blackfilt[joff][i];
#else
            xvalue += y * blackman(i - offset, fcn, filter_l); /* very slow! */
#endif
        }
        outbuf[k] = xvalue;
    }


    /* k = number of samples added to outbuf */
    /* last k sample used data from [j-filter_l/2,j+filter_l-filter_l/2]  */

    /* how many samples of input data were used:  */
    *num_used = Min(len, filter_l + j - filter_l / 2);

    /* adjust our input time counter.  Incriment by the number of samples used,
     * then normalize so that next output sample is at time 0, next
     * input buffer is at time itime[ch] */
    esv.itime[ch] += *num_used - k * resample_ratio;

    /* save the last BLACKSIZE samples into the inbuf_old buffer */
    if (*num_used >= BLACKSIZE) {
        for (i = 0; i < BLACKSIZE; i++)
            inbuf_old[i] = inbuf[*num_used + i - BLACKSIZE];
    }
    else {
        /* shift in *num_used samples into inbuf_old  */
        final int n_shift = BLACKSIZE - *num_used; /* number of samples to shift */

        /* shift n_shift samples by *num_used, to make room for the
         * num_used new samples */
        for (i = 0; i < n_shift; ++i)
            inbuf_old[i] = inbuf_old[i + *num_used];

        /* shift in the *num_used samples */
        for (j = 0; i < BLACKSIZE; ++i, ++j)
            inbuf_old[i] = inbuf[j];

        assert(j == *num_used);
    }
    return k;           /* return the number samples created at the new samplerate */
}

int
isResamplingNecessary(SessionConfig_t cfg)
{
  final int l = (cfg.samplerate_out * 0.9995).toInt();
  final int h = (cfg.samplerate_out * 1.0005).toInt();
  return (cfg.samplerate_in < l) || (h < cfg.samplerate_in) ? 1 : 0;
}

/* copy in new samples from in_buffer into mfbuf, with resampling
   if necessary.  n_in = number of samples from the input buffer that
   were used.  n_out = number of samples copied into mfbuf  */

List<int>
fill_buffer(lame_internal_flags gfc,
            List<typed.Float32List> mfbuf/*[2]*/, List<typed.Float32List> in_buffer/*[2]*/, int nsamples, int n_in, int n_out)
{
    SessionConfig_t cfg = gfc.cfg;
    int     mf_size = gfc.sv_enc.mf_size;
    int     framesize = 576 * cfg.mode_gr;
    int     nout, ch = 0;
    int     nch = cfg.channels_out;

    /* copy in new samples into mfbuf, with resampling if necessary */
    if (isResamplingNecessary(cfg)) {
        do {
            nout =
                fill_buffer_resample(gfc, &mfbuf[ch][mf_size],
                                     framesize, in_buffer[ch], nsamples, n_in, ch);
        } while (++ch < nch);
        n_out = nout;
    }
    else {
        nout = Min(framesize, nsamples);
        do {
//            memcpy(&mfbuf[ch][mf_size], &in_buffer[ch][0], nout * sizeof(mfbuf[0][0]));
        } while (++ch < nch);
        n_out = nout;
        n_in = nout;
    }
    return [n_in, n_out];
}







/***********************************************************************
*
*  Message Output
*
***********************************************************************/

//void
//lame_report_def(const char *format, va_list args)
//{
//    vfprintf(stderr, format, args);
//    fflush(stderr); /* an debug function should flush immediately */
//}
//
//void
//lame_report_fnc(lame_report_function print_f, const char *format, ...)
//{
//    if (print_f) {
//        va_list args;
//        va_start(args, format);
//        print_f(format, args);
//        va_end(args);
//    }
//}
//
//
//void
//lame_debugf(lame_internal_flags gfc, char *format, ...)
//{
//    if (gfc && gfc.report_dbg) {
//        va_list args;
//        va_start(args, format);
//        gfc.report_dbg(format, args);
//        va_end(args);
//    }
//}
//
//
//void
//lame_msgf(lame_internal_flags gfc, char *format, ...)
//{
//    if (gfc && gfc.report_msg) {
//        va_list args;
//        va_start(args, format);
//        gfc.report_msg(format, args);
//        va_end(args);
//    }
//}
//
//
//void
//lame_errorf(lame_internal_flags gfc, const char *format, ...)
//{
//    if (gfc && gfc.report_err) {
//        va_list args;
//        va_start(args, format);
//        gfc.report_err(format, args);
//        va_end(args);
//    }
//}



/***********************************************************************
 *
 *      routines to detect CPU specific features like 3DNow, MMX, SSE
 *
 *  donated by Frank Klemm
 *  added Robert Hegemann 2000-10-10
 *
 ***********************************************************************/


int
has_MMX()
{
    return 0;           /* don't know, assume not */
}

int
has_3DNow()
{
    return 0;           /* don't know, assume not */
}

int
has_SSE()
{
    return 0;           /* don't know, assume not */
}

int
has_SSE2()
{
    return 0;           /* don't know, assume not */
}

void
disable_FPE()
{
///* extremly system dependent stuff, move to a lib to make the code readable */
///*==========================================================================*/
//
//
//
//    /*
//     *  Disable floating point exceptions
//     */
//
//
//
//
//#if defined(__FreeBSD__) && !defined(__alpha__)
//    {
//        /* seet floating point mask to the Linux default */
//        fp_except_t mask;
//        mask = fpgetmask();
//        /* if bit is set, we get SIGFPE on that error! */
//        fpsetmask(mask & ~(FP_X_INV | FP_X_DZ));
//        /*  DEBUGF("FreeBSD mask is 0x%x\n",mask); */
//    }
//#endif
//
//#if defined(__riscos__) && !defined(ABORTFP)
//    /* Disable FPE's under RISC OS */
//    /* if bit is set, we disable trapping that error! */
//    /*   _FPE_IVO : invalid operation */
//    /*   _FPE_DVZ : divide by zero */
//    /*   _FPE_OFL : overflow */
//    /*   _FPE_UFL : underflow */
//    /*   _FPE_INX : inexact */
//    DisableFPETraps(_FPE_IVO | _FPE_DVZ | _FPE_OFL);
//#endif
//
//    /*
//     *  Debugging stuff
//     *  The default is to ignore FPE's, unless compiled with -DABORTFP
//     *  so add code below to ENABLE FPE's.
//     */
//
//#if defined(ABORTFP)
//#if defined(_MSC_VER)
//    {
//#if 0
//        /* rh 061207
//           the following fix seems to be a workaround for a problem in the
//           parent process calling LAME. It would be better to fix the broken
//           application => code disabled.
//         */
//
//        /* set affinity to a single CPU.  Fix for EAC/lame on SMP systems from
//           "Todd Richmond" <todd.richmond@openwave.com> */
//        SYSTEM_INFO si;
//        GetSystemInfo(&si);
//        SetProcessAffinityMask(GetCurrentProcess(), si.dwActiveProcessorMask);
//#endif
//#include <float.h>
//        unsigned int mask;
//        mask = _controlfp(0, 0);
//        mask &= ~(_EM_OVERFLOW | _EM_UNDERFLOW | _EM_ZERODIVIDE | _EM_INVALID);
//        mask = _controlfp(mask, _MCW_EM);
//    }
//#elif defined(__CYGWIN__)
//#  define _FPU_GETCW(cw) __asm__ ("fnstcw %0" : "=m" (*&cw))
//#  define _FPU_SETCW(cw) __asm__ ("fldcw %0" : : "m" (*&cw))
//
//#  define _EM_INEXACT     0x00000020 /* inexact (precision) */
//#  define _EM_UNDERFLOW   0x00000010 /* underflow */
//#  define _EM_OVERFLOW    0x00000008 /* overflow */
//#  define _EM_ZERODIVIDE  0x00000004 /* zero divide */
//#  define _EM_INVALID     0x00000001 /* invalid */
//    {
//        unsigned int mask;
//        _FPU_GETCW(mask);
//        /* Set the FPU control word to abort on most FPEs */
//        mask &= ~(_EM_OVERFLOW | _EM_ZERODIVIDE | _EM_INVALID);
//        _FPU_SETCW(mask);
//    }
//# elif defined(__linux__)
//    {
//
//#  include <fpu_control.h>
//#  ifndef _FPU_GETCW
//#  define _FPU_GETCW(cw) __asm__ ("fnstcw %0" : "=m" (*&cw))
//#  endif
//#  ifndef _FPU_SETCW
//#  define _FPU_SETCW(cw) __asm__ ("fldcw %0" : : "m" (*&cw))
//#  endif
//
//        /*
//         * Set the Linux mask to abort on most FPE's
//         * if bit is set, we _mask_ SIGFPE on that error!
//         *  mask &= ~( _FPU_MASK_IM | _FPU_MASK_ZM | _FPU_MASK_OM | _FPU_MASK_UM );
//         */
//
//        unsigned int mask;
//        _FPU_GETCW(mask);
//        mask &= ~(_FPU_MASK_IM | _FPU_MASK_ZM | _FPU_MASK_OM);
//        _FPU_SETCW(mask);
//    }
//#endif
//#endif /* ABORTFP */
}





//#ifdef USE_FAST_LOG
/***********************************************************************
 *
 * Fast Log Approximation for log2, used to approximate every other log
 * (log10 and log)
 * maximum absolute error for log10 is around 10-6
 * maximum *relative* error can be high when x is almost 1 because error/log10(x) tends toward x/e
 *
 * use it if typical RESULT values are > 1e-5 (for example if x>1.00001 or x<0.99999)
 * or if the relative precision in the domain around 1 is not important (result in 1 is exact and 0)
 *
 ***********************************************************************/


const LOG2_SIZE    =   (512);
const LOG2_SIZE_L2 =   (9);

var log_table = new List<ieee754_float32_t>(LOG2_SIZE + 1);


var init_log_table_init = false;
void
init_log_table()
{
    int     j;

    /* Range for log2(x) over [1,2[ is [0,1[ */
    assert((1 << LOG2_SIZE_L2) == LOG2_SIZE);

    if (!init_log_table_init) {
        for (j = 0; j < LOG2_SIZE + 1; j++)
            log_table[j] = log(1.0 + j / LOG2_SIZE) / log(2.0);
    }
    init_log_table_init = true;
}



ieee754_float32_t
fast_log2(ieee754_float32_t x)
{
    ieee754_float32_t log2val, partial;
    union {
        ieee754_float32_t f;
        int     i;
    } fi;
    int     mantisse;
    fi.f = x;
    mantisse = fi.i & 0x7fffff;
    log2val = ((fi.i >> 23) & 0xFF) - 0x7f;
    partial = (mantisse & ((1 << (23 - LOG2_SIZE_L2)) - 1));
    partial *= 1.0 / ((1 << (23 - LOG2_SIZE_L2)));


    mantisse >>= (23 - LOG2_SIZE_L2);

    /* log2val += log_table[mantisse];  without interpolation the results are not good */
    log2val += log_table[mantisse] * (1.0 - partial) + log_table[mantisse + 1] * partial;

    return log2val;
}

//#else /* Don't use FAST_LOG */
//
//
//void
//init_log_table()
//{
//}
//
//
//#endif

/* end of util.c */
