# RitaPaySDK

RitaPaySDK is pure-swift API to process your payment in iOS applications through Rittal payment gateway.

## Features

- [x] Integrate to Rittal payment gateway with your credintials
- [x] Secure interface to process your payment
- [x] Get transaction result back in your iOS application
- [x] Add your company logo to the payment interface

## Requirements

- **Xcode 11**
- **Swift 5**

## Installation

#### Manually

Add `RitaPaySDK.xcframework` from the build folder to `Frameworks, Libraries, and Embedded Content` section of your Target General settings tab.

#### Cocoapods

Add the following line to your pods file

```
pod 'RitaPaySDK'
```

and then run `pod install` from the terminal

## How to Use

### Configuration

First of all you have to configure RitaPaySDK through the configuration object as follow:

```
import RitaPaySDK
.
.
.
.
.
RitaPayConfiguration.shared.appProtocol = "Your protocol" \\ either "http" or "https", but "https" is recommended
RitaPayConfiguration.shared.appDomain = "The application domain" \\ Rittal Pay provided domain address
RitaPayConfiguration.shared.appPort = "The application port" \\ Rittal Pay provided port address
RitaPayConfiguration.shared.applicationName = "The application name" \\ Rittal Pay provided application name
RitaPayConfiguration.shared.orgnizationUserName = "The orgnization name" \\ Rittal Pay provided orgnization name
RitaPayConfiguration.shared.orgnizationPassword = "The clear text orgnization password" \\ Rittal Pay provided orgnization password in clear text
```

**Optionally:** you can configure the Theme by showing your own logo on the payment view and setting the Theme color as follow:

```
ThemeManager.shared.companyLogoImage = UIImage(named: "companyLogo") \\ Use your company logo here
ThemeManager.shared.themeColor = UIColor.cyan \\ Use your favorite color that is convenient with your App theme
``` 

### Usage

Now after you are done with the application configuration you need to use the SDK views inside your application from the presenting controller (Router) or wahtever class you're using for navigating your app, please do the following:

```
import RitaPaySDK
.
.
.
.
.
\\ Initiate the payment view
let paymentViewController = PaymentViewController()
\\ Assign the checkout id
paymentViewController.checkOutId = "Your checkout id" \\ The checkput id of the transaction under payment
\\ Assign the delegate
paymentViewController.delegate = self \\ Assigning to same class here, note you can assign to whatever class you want
\\ Presenting the view
present(paymentViewController, animated: false, completion: nil)
\*  Conform to PaymentViewDelegate protocol on the designated delegate class
	The delegate has 2 functions to conform to */
\\ This function is used to handle a successful payment operation
func didFinishPayment(_ payment: PaymentResponse?) {
	\\ Do whatever you want with the payment response you get here from a successful payment operation
}
\\ This function is used to handle error 
func didFinishPayment(didAbortWithError error: Error) {
	\\ Handle the error
}


```


## License

MIT


