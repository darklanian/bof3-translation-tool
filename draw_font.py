import argparse
from PIL import Image, ImageDraw, ImageFont
import os
import sys

def draw_font(draw, width, char_size, start, ypos, text, font):
    chars_per_line = width // char_size
    lines = (len(text) + chars_per_line - 1) // chars_per_line
    for i in range(lines):
        line_text = text[i * chars_per_line:(i + 1) * chars_per_line]
        x = 0
        y = start + i * char_size
        c = -1
        for ch in line_text:
            draw.rectangle((x, y, x+char_size, y + char_size + c), fill=0)
            draw.text((x+1, y+ypos), ch, font=font, fill=4)
            draw.text((x, y+ypos), ch, font=font, fill=1)
            x += char_size

def font_path(path):
    if os.path.exists(path):
        return path
    else:
        new_path = os.path.join(sys.path[0], path)
        if os.path.exists(new_path):
            return new_path
        else:
            new_path = os.path.join(os.environ['windir'], "Fonts", path)
            if os.path.exists(new_path):
                return new_path
            else:
                return path
    
def main(args):
    font_8 = ImageFont.truetype(font_path(args.font8), 8)
    ypos_8 = args.font8_ypos
    font_12 = ImageFont.truetype(font_path(args.font12), 12)
    ypos_12 = args.font12_ypos
    
    with open(args.extra_table, encoding='utf-8') as f:
        font0 = ''
        font1 = ''
        font2 = ''
        while line := f.readline():
            line = line.strip()
            ch, code = line.split('=')
            code = int(code,16)
            if code >= 0x5b and code <= 0xfb:
                font0 += ch
            elif code >= 0x1200 and code <= 0x13b8:
                font1 += ch
            elif code >= 0x1a00 and code <= 0x1bb8:
                font2 += ch

    with Image.open(args.input) as img:
        width = 256
        height = 256
        draw = ImageDraw.Draw(img)
        
        draw_font(draw, width, 12, 72, ypos_12, font0, font_12)
        draw_font(draw, width, 8, 169, ypos_8, font0, font_8)
        img.save(os.path.join(args.output, 'font_kr_0.bmp'))
    
        if font1:
            draw.rectangle((0, 0, width, height), fill=0)
            draw_font(draw, width, 12, 0, ypos_12, font1, font_12)
            img.save(os.path.join(args.output, 'font_kr_1.bmp'))
        if font2:
            draw.rectangle((0, 0, width, height), fill=0)
            draw_font(draw, width, 12, 0, ypos_12, font2, font_12)
            img.save(os.path.join(args.output, 'font_kr_2.bmp'))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='draw font for Breath of Fire III from extra table')
    parser.add_argument('--input', '-i', help='input BMP file for font0')
    parser.add_argument('--extra-table', '-t', help='input extra table file')
    parser.add_argument('--font12', help='size 12 font file', default="GALMURI11.ttf")
    parser.add_argument('--font12_ypos', help='size 12 font y position', default=-1)
    parser.add_argument('--font8', help='size 8 font file', default="GALMURI7.ttf")
    parser.add_argument('--font8_ypos', help='size 8 font y position', default=-1)
    parser.add_argument('--output', '-o', help='output directory', default='.')
    main(parser.parse_args())