
import { DatabaseTable } from '../../schema';

export const users = new DatabaseTable('users', {
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
