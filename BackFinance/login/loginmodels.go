package login

type UserOutput struct {
	ID   string `json:"id"`
	Nome string `json:"nome"`
}

type NewUserInput struct {
	Nome     string `json:"nome"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

type ForgotPasswordEmailInput struct {
	Email string `json:"email"`
}

type ForgotPasswordEmailCodeInput struct {
	Email string `json:"email"`
	Code  string `json:"code"`
}

type ForgotPasswordEmailNewPasswordInput struct {
	Email       string `json:"email"`
	NewPassword string `json:"newpassword"`
}
