// Generated by Apple Swift version 2.1 (swiftlang-700.1.101.6 clang-700.1.76)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreGraphics;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIWindow;
@class UIApplication;
@class NSObject;

SWIFT_CLASS("_TtC11Tap_Up_Game11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * __nullable window;
- (BOOL)application:(UIApplication * __nonnull)application didFinishLaunchingWithOptions:(NSDictionary * __nullable)launchOptions;
- (void)applicationWillResignActive:(UIApplication * __nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * __nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * __nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * __nonnull)application;
- (void)applicationWillTerminate:(UIApplication * __nonnull)application;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UIView;
@class AVAudioPlayer;
@class UIDynamicAnimator;
@class UICollisionBehavior;
@protocol UIDynamicItem;
@class UIButton;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC11Tap_Up_Game18GameViewController")
@interface GameViewController : UIViewController <UICollisionBehaviorDelegate>
@property (nonatomic, weak) IBOutlet UIButton * __null_unspecified startButtonOutlet;
- (IBAction)startButtonAction:(id __nonnull)sender;
@property (nonatomic, readonly, strong) UIView * __nonnull ballOne;
@property (nonatomic) float screenWidth;
@property (nonatomic) float screenHeight;
@property (nonatomic, copy) NSArray<UIView *> * __nonnull allViewsArray;
@property (nonatomic) NSInteger ballCount;
@property (nonatomic) NSInteger timeSurvived;
@property (nonatomic, strong) AVAudioPlayer * __nonnull audioPlayer;
@property (nonatomic, strong) UIDynamicAnimator * __nonnull dynamicAnimator;
@property (nonatomic, copy) NSArray<NSString *> * __nonnull colorsArray;
- (void)SetUpView;
- (void)StartGame;
- (void)ResetGame;
- (void)GameLost;
- (void)delay:(double)delay closure:(void (^ __nonnull)(void))closure;
- (void)AddDynamicBehavior:(NSArray<UIView *> * __nonnull)Array;
- (void)collisionBehavior:(UICollisionBehavior * __nonnull)behavior beganContactForItem:(id <UIDynamicItem> __nonnull)item1 withItem:(id <UIDynamicItem> __nonnull)item2 atPoint:(CGPoint)p;
- (void)viewDidLoad;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11Tap_Up_Game10HighScores")
@interface HighScores : UIViewController
- (void)viewDidLoad;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIStoryboardSegue;

SWIFT_CLASS("_TtC11Tap_Up_Game11OptionsMenu")
@interface OptionsMenu : UIViewController
@property (nonatomic) BOOL soundEffects;
@property (nonatomic) BOOL menuAnimations;
@property (nonatomic) BOOL colorChanges;
@property (nonatomic) BOOL backgroundMusic;
- (IBAction)soundEffectsOnButton:(id __nonnull)sender;
- (IBAction)soundEffectsOffButton:(id __nonnull)sender;
- (IBAction)MenuAnimationsOnButton:(id __nonnull)sender;
- (IBAction)MenuAnimationsOffButton:(id __nonnull)sender;
- (IBAction)BackgroundMusicOnButton:(id __nonnull)sender;
- (IBAction)BackgroundMusicOffButton:(id __nonnull)sender;
- (IBAction)ColorChangesOnButton:(id __nonnull)sender;
- (IBAction)ColorChangesOffButton:(id __nonnull)sender;
- (IBAction)ResetHighScoresButton:(id __nonnull)sender;
- (void)viewDidLoad;
- (void)prepareForSegue:(UIStoryboardSegue * __nonnull)segue sender:(id __nullable)sender;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11Tap_Up_Game14ViewController")
@interface ViewController : UIViewController <UICollisionBehaviorDelegate>
@property (nonatomic, strong) UIDynamicAnimator * __nonnull dynamicAnimator;
@property (nonatomic) BOOL menuAnimations;
@property (nonatomic) BOOL colorChanges;
@property (nonatomic) BOOL backGroundMusic;
@property (nonatomic) BOOL soundEffects;
- (void)SetUpViewsDynamic;
- (void)SetUpViews;
- (void)AddDynamicBehavior:(NSArray<UIView *> * __nonnull)Array;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
