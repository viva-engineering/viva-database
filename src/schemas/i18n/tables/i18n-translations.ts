
import { TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface I18nTranslationsColumns {
	label_id: number;
	language_code: string;
	label_text: string;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const i18nTranslations = new DatabaseTable('i18n_translations', <ColumnList<I18nTranslationsColumns>> {
	labelId: 'label_id' as const,
	languageCode: 'language_code' as const,
	labelText: 'label_text' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
