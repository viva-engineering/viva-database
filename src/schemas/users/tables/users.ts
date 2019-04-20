
import { Bit, TimestampString, DateString, PhoneNumberString, EmailString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface UsersColumns {
	id: number;
	email: EmailString;
	name: string;
	phone: PhoneNumberString;
	location: string;
	birthday: DateString;
	preferred_language: string;
	user_code: string;
	active: Bit;
	email_validated: Bit;
	explicit_content_visible: Bit;
	user_role_id: number;
	privacy_settings_id: number;
	lock_active: Bit;
	lock_explicit_content_visible: Bit;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const users = new DatabaseTable('users', <ColumnList<UsersColumns>> {
	id: 'id' as const,
	email: 'email' as const,
	name: 'name' as const,
	phone: 'phone' as const,
	location: 'location' as const,
	birthday: 'birthday' as const,
	preferredLanguage: 'preferred_language' as const,
	userCode: 'user_code' as const,
	active: 'active' as const,
	emailValidated: 'email_validated' as const,
	explicitContentVisible: 'explicit_content_visible' as const,
	userRoleId: 'user_role_id' as const,
	privacySettingsId: 'privacy_settings_id' as const,
	lockActive: 'lock_active' as const,
	lockExplicitContentVisible: 'lock_explicit_content_visible' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
