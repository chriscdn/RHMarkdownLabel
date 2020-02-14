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

@interface RHMarkdownLabel()
@property (nonatomic, strong) NSAttributedString *truncationToken;
@property (nonatomic, assign) NSInteger lines;
@end

@implementation RHMarkdownLabel

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
        self.numberOfLines = 0;
        self.lines = 0;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.numberOfLines = 0;
        self.lines = 0;
    }
    return self;
}

-(XNGMarkdownParser *)parser {
    
    if (_parser == nil) {
        
        self.parser = [XNGMarkdownParser new];
        
        _parser.paragraphFont = self.font;
        _parser.linkFontName = self.font.fontName;
        
        // what about bold, italic, bold-italic?
        
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        
        paragraphStyle.minimumLineHeight = self.minimumLineHeight;
        paragraphStyle.maximumLineHeight = self.maximumLineHeight;
        
        //        _parser.topAttributes = @{
        //                                  NSParagraphStyleAttributeName: paragraphStyle,
        //                                  NSForegroundColorAttributeName: self.textColor
        //                                  };
        
        if (@available(iOS 13.0, *)) {
            _parser.topAttributes = @{
                NSParagraphStyleAttributeName: paragraphStyle,
                NSForegroundColorAttributeName: [UIColor labelColor]
            };
        } else {
            _parser.topAttributes = @{
                NSParagraphStyleAttributeName: paragraphStyle,
                NSForegroundColorAttributeName: [UIColor darkTextColor]
            };
        }
    }
    
    return _parser;
}

-(void)setMarkdown:(NSString *)markdown {
    _markdown = markdown;
    self.text = [self.parser attributedStringFromMarkdownString:markdown];
    
    [self toggleNothing];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([self linkAtPoint:[touch locationInView:self]]) {
        // we have a link.. look at super for implementation
        [super touchesBegan:touches withEvent:event];
    } else if (self.lines == 0) {
        [super touchesBegan:touches withEvent:event];
    } else {
        [self toggleTruncation];
    }
}

-(void)addTruncationToken:(NSAttributedString *)token numberOfLines:(NSInteger)numberOfLines {
    
    [self setTruncationToken:token];
    [self setLines:numberOfLines];
    
    [self setNumberOfLines:0];
    [self toggleTruncation];
}

-(NSAttributedString *)truncationToken {
    if (_truncationToken == nil) {
        NSMutableAttributedString *token = [[NSMutableAttributedString alloc] initWithString:@"\u2026"];
        if (@available(iOS 13.0, *)) {
            [token appendAttributedString:[[NSAttributedString alloc]
                                           initWithString:NSLocalizedString(@"more", nil) attributes:@{NSForegroundColorAttributeName:[UIColor secondaryLabelColor]}]];
        } else {
            [token appendAttributedString:[[NSAttributedString alloc]
                                           initWithString:NSLocalizedString(@"more", nil) attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}]];
        }
        
        self.truncationToken = token;
    }
    
    return _truncationToken;
}

-(void)expand {
    //    if (self.numberOfLines > 0) {
    [self setNumberOfLines:0];
    [self setAttributedTruncationToken:nil];
    //    }
}

-(void)collapse {
    //    if (self.numberOfLines == 0) {
    [self setNumberOfLines:self.lines];
    //        [self setAttributedTruncationToken:self.truncationToken];
    
    if (self.markdown.length) {
        [self setAttributedTruncationToken:self.truncationToken];
    } else {
        // No text? Unset the truncationToken.
        [self setAttributedTruncationToken:nil];
    }
    //    }
}

-(void)toggleTruncation {
    if (self.numberOfLines == 0) {
        [self collapse];
    } else {
        [self expand];
    }
}

-(void)toggleNothing {
    if (self.numberOfLines == 0) {
        [self expand];
    } else {
        [self collapse];
    }
}

@end
