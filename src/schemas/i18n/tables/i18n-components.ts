
import { TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface I18nComponentsColumns {
	code: string;
	description: string;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const i18nComponents = new DatabaseTable('i18n_components', <ColumnList<I18nComponentsColumns>> {
	code: 'code' as const,
	description: 'description' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
