
import { Bit, TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface I18nLanguagesColumns {
	code: string;
	description: string;
	native_description: string;
	active: Bit;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const i18nLanguages = new DatabaseTable('i18n_languages', <ColumnList<I18nLanguagesColumns>> {
	code: 'code' as const,
	description: 'description' as const,
	nativeDescription: 'native_description' as const,
	active: 'active' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
