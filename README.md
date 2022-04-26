<h1 align="center">ShiftEz</h1>

<h5 align="center">A native macOS Application for automating STS switch-role procedure to IAM Role/Profile.</h5> 
<br>

## Usage
The application will dig in your `~/.aws` folder for available profiles and lets
you choose one of those through the Pickers. Then insert the `arn` of the virtual MFA device
and you're good to go; of course, OTP is required as well.

<div align="center">
<img width=400 src="https://github.com/danielivanovz/Shiftez/blob/main/Shiftez.png?raw=true", alt="screenshot"/>
</div>

## Requirments
The application relies on `aws cli`, and you can find informations on how to install it here at this [link](https://aws.amazon.com/cli/)
