
import { Bit, TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface SessionsColumns {
	id: number;
	user_id: number;
	expiration: TimestampString;
	application_id: number;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const sessions = new DatabaseTable('sessions', {
	id: 'id' as const,
	userId: 'user_id' as const,
	expiration: 'expiration' as const,
	applicationId: 'application_id' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
