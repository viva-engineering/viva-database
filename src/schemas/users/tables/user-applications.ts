
import { Bit, TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface UserApplicationsColumns {
	id: number;
	user_id: number;
	application_id: number;
	user_key_digest: string;
	active: Bit;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const userApplications = new DatabaseTable('user_applications', <ColumnList<UserApplicationsColumns>> {
	id: 'id' as const,
	userId: 'user_id' as const,
	applicationId: 'application_id' as const,
	userKeyDigest: 'user_key_digest' as const,
	active: 'active' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
