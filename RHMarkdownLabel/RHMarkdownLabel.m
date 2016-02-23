//
//  RHMarkdownLabel.m
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "RHMarkdownLabel.h"
#import "XNGMarkdownParser.h"

@interface RHMarkdownLabel()
@property (nonatomic, strong) XNGMarkdownParser *parser;
@end

@implementation RHMarkdownLabel

-(XNGMarkdownParser *)parser {

    if (_parser == nil) {
    
        self.parser = [XNGMarkdownParser new];
        
        _parser.paragraphFont = self.font;
        _parser.linkFontName = _parser.paragraphFont.fontName;
        
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        
        paragraphStyle.minimumLineHeight = self.minimumLineHeight;
        paragraphStyle.maximumLineHeight = self.maximumLineHeight;
        
        _parser.topAttributes = @{
                                 NSParagraphStyleAttributeName: paragraphStyle,
                                 NSForegroundColorAttributeName: self.textColor
                                 };
    }
    
    return _parser;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
    }
    return self;
}

-(void)setMarkdown:(NSString *)markdown {
    _markdown = markdown;
    self.text = [self.parser attributedStringFromMarkdownString:markdown];
}

-(void)setDidSelectLinkWithURLBlock:(void (^)(RHMarkdownLabel *label, NSURL *url))didSelectLinkWithURLBlock {
    _didSelectLinkWithURLBlock = [didSelectLinkWithURLBlock copy];
    self.enabledTextCheckingTypes = NSTextCheckingTypeLink;
}


-(void)attributedLabel:(RHMarkdownLabel *)label didSelectLinkWithURL:(NSURL *)url {
    if (self.didSelectLinkWithURLBlock) {
        self.didSelectLinkWithURLBlock(label, url);
    }
}

@end