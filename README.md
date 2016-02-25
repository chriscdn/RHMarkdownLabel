# RHMarkdownLabel

## Introduction

`RHMarkdownLabel` is `UILabel` replacement for supporting markdown.  `RHMarkdownLabel` provides a `-setMarkdown:`method, which transparently converts the markdown string to an `NSAttributedString ` and display it in the label. For example:

	NSString *md = @"This is **bold**.";
	[self.myLabel setMarkdown:md];

Most of the logic behind `RHMarkdownLabel` is contained in its two dependencies.  `RHMarkdownLabel` is a subclass of [`TTTAttributedLabel`](https://github.com/TTTAttributedLabel/TTTAttributedLabel) and uses [`XNGMarkdownParser`](https://github.com/xing/XNGMarkdownParser)
to parse and convert the markdown to an `NSAttributedString `.  `RHMarkdownLabel` is just a glue between these repositories.

## Handling Links

`RHMarkdownLabel` provides a block interface for handling tapped links (instead of using the delegate pattern of `TTTAttributedLabel`).  For example:

	[self.myLabel setDidSelectLinkWithURLBlock:^(`RHMarkdownLabel` *label, NSURL *url) {
		NSLog(@"The user tapped on %@.", url.absoluteString);
	}];
	
Block for other types such as addresses, phone numbers, dates, and transit information is still pending.
	
## NSString+markdown.h Category

`RHMarkdownLabel` also contains an `NSString` category for processing markdown.
	
## Contact

Are you using `RHMarkdownLabel` in your project?  I'd love to hear from you!

profile: [Christopher Meyer](https://github.com/chriscdn)  
e-mail: [chris@schwiiz.org](mailto:chris@schwiiz.org)  
twitter: [@chriscdn](https://twitter.com/chriscdn)  
blog: [schwiiz.org](http://schwiiz.org/)

## License

`RHMarkdownLabel` is available under the MIT license. See the LICENSE file for more information.