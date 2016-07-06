//
//  OKSourceEditViewController.h
//  PEGKit
//
//  Created by Todd Ditchendorf on 4/24/13.
//
//

#import <Cocoa/Cocoa.h>
#import <OkudaKit/OKSyntaxHighlighter.h>

@class OKTextView;
@class OKGutterView;

extern NSString * const OKTabWidthKey;
extern NSString * const OKConvertTabsToSpacesKey;
extern NSString * const OKAutocompletionEnabledKey;
extern NSString * const OKAutocompletionFuzzyMatchKey;
extern NSString * const OKAutocompletionDelayKey;
extern NSString * const OKCanAcceptCompletionDelayKey;
extern NSString * const OKWrapTextKey;

extern NSString * const OKWrapTextDidChangeNotification;

typedef NS_ENUM(NSUInteger, OKTextViewRefreshType) {
    OKTextViewRefreshTypeDynamic = 0,
    OKTextViewRefreshTypeFullRange = 1,
    OKTextViewRefreshTypeVisibleRange = 2,
};

@class OKViewController;

@protocol OKViewControllerDelegate <NSObject>
@optional
- (BOOL)okviewController:(OKViewController *)okvc doCommandBySelector:(SEL)sel;
- (BOOL)okviewController:(OKViewController *)okvc shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(NSString *)replacementString;
@end

@interface OKViewController : NSViewController <NSTextViewDelegate, NSLayoutManagerDelegate, NSTableViewDataSource, NSTableViewDelegate>

- (instancetype)initWithDefaultNib;

- (void)reloadStylesheets:(id)sender;
- (void)refresh:(id)sender;
- (void)renderGutterNow;
- (void)renderGutterLater;

- (void)highlightLineNumber:(NSUInteger)lineNum; // scrollToVisible=YES
- (void)highlightLineNumber:(NSUInteger)lineNum scrollToVisible:(BOOL)scroll;
- (void)highlightRanges:(NSArray *)hiRanges focusRanges:(NSArray *)focusRanges;

- (NSColor *)triggerBackgroundFlagColor;
- (NSColor *)triggerBackgroundRenderColor;

- (NSColor *)highlightFillColor;
- (NSColor *)highlightStrokeColor;

- (NSDictionary *)defaultAttributes;
- (NSDictionary *)selectionAttributes;
- (NSDictionary *)focusAttributes;

- (void)moveBreakpointsAfterLine:(NSUInteger)lineNum by:(NSInteger)diff;
- (void)deleteBreakpointsInLineRange:(NSRange)lineRange;
- (void)captureBreakpointsForUndo;

- (void)setSourceString:(NSString *)str encoding:(NSStringEncoding)enc; // clearUndo=YES
- (void)setSourceString:(NSString *)str encoding:(NSStringEncoding)enc clearUndo:(BOOL)clearUndo;

- (void)setGrammarName:(NSString *)name attributeProvider:(id <OKSyntaxHighlighterAttributesProvider>)provider;

@property (nonatomic, assign) id <OKViewControllerDelegate>delegate;

@property (nonatomic, retain) IBOutlet OKTextView *textView;
@property (nonatomic, retain) IBOutlet OKGutterView *gutterView;

@property (nonatomic, retain, readonly) NSString *sourceString;
@property (nonatomic, assign, readonly) NSStringEncoding sourceStringEncoding;
@property (nonatomic, copy, readonly) NSString *grammarName;

@property (nonatomic, assign) BOOL hasGutterView; // default YES

@property (nonatomic, assign) BOOL useDefaultAttributes;
@property (nonatomic, assign) BOOL suppressHighlighting;
@property (nonatomic, assign) BOOL enableDefinitionLinking;

@property (nonatomic, assign) OKTextViewRefreshType refreshType;

@property (nonatomic, retain) OKSyntaxHighlighter *highlighter;
@end
