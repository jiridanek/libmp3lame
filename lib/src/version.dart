/*
 *      Version numbering for LAME.
 *
 *      Copyright (c) 1999 A.L. Faber
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

/*!
  \file   version.c
  \brief  Version numbering for LAME.

  Contains functions which describe the version of LAME.

  \author A.L. Faber
  \version \$Id: version.c,v 1.32.2.2 2011/11/18 09:18:28 robert Exp $
  \ingroup libmp3lame
*/

part of libmp3lame;

const LAME_URL = "http://lame.sf.net";

const LAME_MAJOR_VERSION =     3; /* Major version number */
const LAME_MINOR_VERSION =    99; /* Minor version number */
const LAME_TYPE_VERSION  =     2; /* 0:alpha 1:beta 2:release */
const LAME_PATCH_VERSION =     5; /* Patch level */
const LAME_ALPHA_VERSION =    (LAME_TYPE_VERSION==0);
const LAME_BETA_VERSION  =    (LAME_TYPE_VERSION==1);
const LAME_RELEASE_VERSION =  (LAME_TYPE_VERSION==2);

const PSY_MAJOR_VERSION  =     1; /* Major version number */
const PSY_MINOR_VERSION  =     0; /* Minor version number */
const PSY_ALPHA_VERSION  =     0; /* Set number if this is an alpha version, otherwise zero */
const PSY_BETA_VERSION   =     0; /* Set number if this is a beta version, otherwise zero */

get LAME_VERSION_STRING {
  var LAME_PATCH_LEVEL_STRING;
  if (LAME_ALPHA_VERSION) {
    LAME_PATCH_LEVEL_STRING = " alpha ${LAME_PATCH_VERSION}";
  }
  if (LAME_BETA_VERSION) {
    LAME_PATCH_LEVEL_STRING = " beta ${LAME_PATCH_VERSION}";
  }
  if (LAME_RELEASE_VERSION) {
    if (LAME_PATCH_VERSION) {
      LAME_PATCH_LEVEL_STRING = " release ${LAME_PATCH_VERSION}";
    }
    LAME_PATCH_LEVEL_STRING = "";
  }
  return "${LAME_MAJOR_VERSION} ${LAME_MINOR_VERSION}${LAME_PATCH_LEVEL_STRING}";
}

class lame_version_t {
    /* generic LAME version */
    int major;
    int minor;
    int alpha;               /* 0 if not an alpha version                  */
    int beta;                /* 0 if not a beta version                    */

    /* version of the psy model */
    int psy_major;
    int psy_minor;
    int psy_alpha;           /* 0 if not an alpha version                  */
    int psy_beta;            /* 0 if not a beta version                    */

    /* compile time features */
    String features;    /* Don't make assumptions about the contents! */
}

//*! Get the LAME version string. */
//*!
//  \param void
//  \return a pointer to a string which describes the version of LAME.
//*/
String
get_lame_version()
{                       /* primary to write screen reports */
    /* Here we can also add informations about compile time configurations */

  if (LAME_ALPHA_VERSION) {
    return "${LAME_MAJOR_VERSION}  ${LAME_MINOR_VERSION} (alpha ${LAME_PATCH_VERSION}, __DATE__  __TIME__ )";
  } else if (LAME_BETA_VERSION) {
    return "${LAME_MAJOR_VERSION}  ${LAME_MINOR_VERSION} (beta ${LAME_PATCH_VERSION} ,  __DATE__ )";
  } else if (LAME_RELEASE_VERSION && (LAME_PATCH_VERSION > 0)) {
    return "${LAME_MAJOR_VERSION}  ${LAME_MINOR_VERSION}  ${LAME_PATCH_VERSION}";
  } else {
    return "${LAME_MAJOR_VERSION}  ${LAME_MINOR_VERSION}";
  }
}


//*! Get the short LAME version string. */
//*!
//  It's mainly for inclusion into the MP3 stream.
//
//  \param void
//  \return a pointer to the short version of the LAME version string.
//*/
String
get_lame_short_version()
{
    /* adding date and time to version string makes it harder for output
       validation */

  if (LAME_ALPHA_VERSION) {
    return "${LAME_MAJOR_VERSION}  ${LAME_MINOR_VERSION}  (alpha  ${LAME_PATCH_VERSION} )";
  } else if (LAME_BETA_VERSION) {
    return "${LAME_MAJOR_VERSION}  ${LAME_MINOR_VERSION}  (beta  ${LAME_PATCH_VERSION} )";
  } else if (LAME_RELEASE_VERSION && (LAME_PATCH_VERSION > 0)) {
    return "${LAME_MAJOR_VERSION}  ${LAME_MINOR_VERSION}  ${LAME_PATCH_VERSION}";
  } else {
    return "${LAME_MAJOR_VERSION}  ${LAME_MINOR_VERSION}";
  }
}

//*! Get the _very_ short LAME version string. */
//*!
//  It's used in the LAME VBR tag only.
//
//  \param void
//  \return a pointer to the short version of the LAME version string.
//*/
String
get_lame_very_short_version()
{
    /* adding date and time to version string makes it harder for output
       validation */
  var P = "";
  if (LAME_ALPHA_VERSION) {
    P = "a";
  } else if (LAME_BETA_VERSION) {
    P = "b";
  } else if (LAME_RELEASE_VERSION && (LAME_PATCH_VERSION > 0)) {
    P = "r";
  }

  if (LAME_PATCH_VERSION > 0) {
    return "LAME ${LAME_MAJOR_VERSION}  ${LAME_MINOR_VERSION} ${P} ${LAME_PATCH_VERSION}";
  } else {
    return "LAME ${LAME_MAJOR_VERSION}  ${LAME_MINOR_VERSION} ${P}";
  }
}

//*! Get the _very_ short LAME version string. */
//*!
//  It's used in the LAME VBR tag only, limited to 9 characters max.
//  Due to some 3rd party HW/SW decoders, it has to start with LAME.
//
//  \param void
//  \return a pointer to the short version of the LAME version string.
// */
String
get_lame_tag_encoder_short_version()
{
  /* FIXME: new scheme / new version counting / drop versioning here ? */
  return "LAME ${LAME_MAJOR_VERSION}  ${LAME_MINOR_VERSION}";
}

//
///*! Get the version string for GPSYCHO. */
///*!
//  \param void
//  \return a pointer to a string which describes the version of GPSYCHO.
//*/
String
get_psy_version()
{
  if (PSY_ALPHA_VERSION > 0) {
    return "${PSY_MAJOR_VERSION}.{${PSY_MINOR_VERSION} (alpha ${PSY_ALPHA_VERSION}, __DATE__ __TIME__)";
  } else if (PSY_BETA_VERSION > 0) {
    return "${PSY_MAJOR_VERSION}.${PSY_MINOR_VERSION} (beta ${PSY_BETA_VERSION}, __DATE__)";
  } else {
    return "${PSY_MAJOR_VERSION}.${PSY_MINOR_VERSION}";
  }
}
//
//
///*! Get the URL for the LAME website. */
///*!
//  \param void
//  \return a pointer to a string which is a URL for the LAME website.
//*/
String
get_lame_url()
{
  return LAME_URL;
}
//
//
///*! Get the numerical representation of the version. */
///*!
//  Writes the numerical representation of the version of LAME and
//  GPSYCHO into lvp.
//
//  \param lvp
//*/
void
get_lame_version_numerical(lame_version_t lvp)
{
    String features = ""; /* obsolete */

    /* generic version */
    lvp.major = LAME_MAJOR_VERSION;
    lvp.minor = LAME_MINOR_VERSION;
if (LAME_ALPHA_VERSION) {
    lvp.alpha = LAME_PATCH_VERSION;
    lvp.beta = 0;
} else if (LAME_BETA_VERSION) {
    lvp.alpha = 0;
    lvp.beta = LAME_PATCH_VERSION;
} else {
    lvp.alpha = 0;
    lvp.beta = 0;
}

    /* psy version */
    lvp.psy_major = PSY_MAJOR_VERSION;
    lvp.psy_minor = PSY_MINOR_VERSION;
    lvp.psy_alpha = PSY_ALPHA_VERSION;
    lvp.psy_beta = PSY_BETA_VERSION;

    /* compile time features */
    /*@-mustfree@ */
    lvp.features = features;
    /*@=mustfree@ */
}
//
//
String
get_lame_os_bitness()
{
    String strXX = "";
    String str32 = "32bits";
    String str64 = "64bits";

    return strXX;

//    switch (sizeof(void *)) {
//    case 4:
//        return str32;
//
//    case 8:
//        return str64;
//
//    default:
//        return strXX;
//    }
}
//
///* end of version.c */
