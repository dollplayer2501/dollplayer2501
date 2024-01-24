#! /usr/bin/env python3
# -*- coding: utf-8 -*-


#
# Fred's ImageMagick Scripts: POPART
#   http://www.fmwconcepts.com/imagemagick/popart/index.php
#
# Fred's ImageMagick Scripts: VINTAGE1
#   http://www.fmwconcepts.com/imagemagick/vintage1/index.php
#
# When used in this script
# - chmod 0755
# - Can be renamed, see `const_popart_filename`, `const_vintage1_filename`
#
# scratchy window | For use in your creations, please credit m… | Flickr
#   https://www.flickr.com/photos/borealnz/2473360890
#   size: 2048x1367
# - can be renamed `const_overlay_image_filename`
#


import sys
import os
import argparse
import subprocess
import glob
import re


if __name__ == "__main__":

    const_base_image_filename = 'IMG_4604.png'

    const_popart_filename = './__popart'
    const_vintage1_filename = './__vintage1'
    const_overlay_image_filename = '__2473360890_47e771a3e6_k.jpg'

    const_color_dic = {
        'apple': {
            'popart': 'yellow red red red',
            'polygon': '0,0 380,0 880,1512 0,1512',
        },
        'linux': {
            'popart': 'yellow green green green',
            'polygon': '380,0 880,1512 1600,1512 1170,0',
        },
        'windows': {
            'popart': 'yellow blue blue blue',
            'polygon': '1170,0 1600,1512 2016,1512 2016,0',
        },
        '_base': {
            'popart': 'yellow yellow yellow yellow',
            'polygon': '',
        },
    }

    const_sns_dic = {
        'twitter': {
            'crop': '2016x672+0+400',
            'resize': '1500x',
        },
        'facebook': {
            'crop': '1640x720+100+400',
            'resize': '',
        },
    }


    #
    print('4032x3024 to 2016x1512')
    #

    subprocess.run([
            'convert', '-strip', '-resize', '2016x1512', '-quality', '90',
            const_base_image_filename, '_tmp_IMG_4604__resize.mpc',
        ], encoding = 'utf-8')


    #
    print('Fred''s ImageMagick Scripts: POPART')
    # http://www.fmwconcepts.com/imagemagick/popart/index.php
    #

    for os_name in const_color_dic:
        subprocess.run([
                const_popart_filename, '-r', '1', '-c', '1', '-g', '0', '-i', 'bilinear', '-c1',
                const_color_dic[os_name]['popart'],
                '_tmp_IMG_4604__resize.mpc', './_tmp__popart_' + os_name + '.mpc',
            ], encoding = 'utf-8')


    #
    print('Create mask image')
    #

    for os_name in const_color_dic:
        if 0 < len(const_color_dic[os_name]['polygon']):
            subprocess.run([
                    'convert', '-size', '2016x1512', 'xc:#00000000', '-fill', '#ff00ffff', '-draw',
                    'polygon ' + const_color_dic[os_name]['polygon'],
                    '_tmp__mask_base_' + os_name + '.mpc',
                ], encoding = 'utf-8')


    #
    print('Masking')
    #

    for os_name in const_color_dic:
        if 0 < len(const_color_dic[os_name]['polygon']):
            subprocess.run([
                    'composite', '-compose', 'dst-in',
                    '_tmp__mask_base_' + os_name + '.mpc', './_tmp__popart_' + os_name + '.mpc',
                    '-alpha', 'on', '_tmp__mask_masking_' + os_name + '.mpc',
                ], encoding = 'utf-8')


    #
    print('Combined, composite, compound')
    #

    subprocess.run([
            'composite', '-compose', 'over',
            '_tmp__mask_masking_apple.mpc', '_tmp__mask_masking_linux.mpc',
            '_tmp_zz1.mpc',
        ], encoding = 'utf-8')

    subprocess.run([
            'composite', '-compose', 'over',
            '_tmp_zz1.mpc', '_tmp__mask_masking_windows.mpc',
            '_tmp_zz2.mpc',
        ], encoding = 'utf-8')


    #
    print('Crop Twitter size(1500x500)')
    #

    """
    subprocess.run([
            'convert', '-crop', '2016x672+0+400',
            '_tmp_zz2.mpc',
            '_tmp_zz3_twitter_crop.mpc',
        ], encoding = 'utf-8')
    """

    subprocess.run([
            'convert', '-crop', const_sns_dic['twitter']['crop'],
            '_tmp_zz2.mpc',
            '_tmp_zz3_twitter_crop.mpc',
        ], encoding = 'utf-8')


    """
    const_sns_dic = {
        'twitter': {
            'crop': '2016x672+0+400',
            'resize': '1500x',
        },
        'facebook': {
    """






    #
    print('Fred''s ImageMagick Scripts: VINTAGE1')
    #

    subprocess.run([
            const_vintage1_filename,
            '_tmp_zz3_twitter_crop.mpc', const_overlay_image_filename,
            '_tmp_zz4_twitter_vintage.mpc',
        ], encoding = 'utf-8')


    #
    print('Resize, Twitter')
    #

    subprocess.run([
            'convert', '-resize', const_sns_dic['twitter']['resize'], '-quality', '90',
#            'convert', '-resize', '1500x', '-quality', '90',
            '_tmp_zz4_twitter_vintage.mpc',
            'IMG_4604_twitter.png',
        ], encoding = 'utf-8')


    #
    print('Crop Facebook size(1640x720)')
    #  PC: 820x312
    #  Smart Phone: 640x360
    #

    subprocess.run([
#            'convert', '-crop', '1640x720+100+400',
            'convert', '-crop', const_sns_dic['facebook']['crop'],
            '_tmp_zz2.mpc',
            '_tmp_zz3_facebook_crop.mpc',
        ], encoding = 'utf-8')


    #
    print('Fred''s ImageMagick Scripts: VINTAGE1')
    #

    subprocess.run([
            const_vintage1_filename,
            '_tmp_zz3_facebook_crop.mpc', const_overlay_image_filename,
            'IMG_4604_facebook.png',
        ], encoding = 'utf-8')


    #
    #
    #

    for f in glob.glob('./**', recursive = False):
        if re.search('.+\.(mpc|cache)$', f):
            os.remove(f)


    print('END')
    sys.exit()
