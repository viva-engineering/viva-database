
import { Bit, TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface CredentialsColumns {
	user_id: number;
	password_digest: string;
	is_active: Bit;
	is_compromised: Bit;
	require_security_question: Bit;
	require_multi_factor: Bit;
	password_expiration: string;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const credentials = new DatabaseTable('credentials', <ColumnList<CredentialsColumns>> {
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
