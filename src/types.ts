
// Hopefully typescript eventually supports pattern types and these will become useful.
// For now, they just provide a little extra info when you actually read the type data
export type DateString = string;
export type TimestampString = string;
export type PhoneNumberString = string;
export type EmailString = string;

export const enum Bit {
	False = 0,
	True = 1
}

export const enum PrivacyFlag {
	Private = 0,
	FriendsOnly = 1,
	Public = 2
}

export const enum VisibilityFlag {
	NotVisible = 0,
	Visible = 1
}

/**
 * Contains all of the special user roles with elevated permissions that
 * can be assigned to a user
 */
export enum UserRole {
	System = 'SYSTEM',
	Admin = 'ADMIN',
	SuperModerator = 'SUPER_MODERATOR',
	Moderator = 'MODERATOR',
	Localization = 'LOCALIZATION'
}
