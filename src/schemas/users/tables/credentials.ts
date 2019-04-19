
import { DatabaseTable } from '../../schema';

export const credentials = new DatabaseTable('credentials', {
	userId: 'user_id' as const,
	passwordDigest: 'password_digest' as const,
	isActive: 'is_active' as const,
	isCompromised: 'is_compromised' as const,
	requireSecurityQuestion: 'require_security_question' as const,
	requireMultiFactor: 'require_multi_factor' as const,
	passwordExpiration: 'password_expiration' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
