
import { TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface I18nLabelsColumns {
	id: number;
	code: string;
	component_code: string;
	description: string;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const i18nLabels = new DatabaseTable('i18n_labels', <ColumnList<I18nLabelsColumns>> {
	id: 'id' as const,
	code: 'code' as const,
	componentCode: 'component_code' as const,
	description: 'description' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
