import { LightningElement, api, wire } from 'lwc';
import { getRecord, updateRecord } from 'lightning/uiRecordApi';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';

import OBJECT_API from '@salesforce/schema/CMPL123QMS__CAPA__c';
import FIELD_API from '@salesforce/schema/CMPL123QMS__CAPA__c.Correct_Specification__c';
import ID_FIELD from '@salesforce/schema/CMPL123QMS__CAPA__c.Id';

export default class YesNoNaRadio extends LightningElement {
    @api recordId;

    value;
    draftValue;
    isEditing = false;
    options = [];

    @wire(getObjectInfo, { objectApiName: OBJECT_API })
    objectInfo;

    @wire(getPicklistValues, {
        recordTypeId: '$objectInfo.data.defaultRecordTypeId',
        fieldApiName: FIELD_API
    })
    wiredPicklist({ data }) {
        if (data) {
            this.options = data.values.map(v => ({
                label: v.label,
                value: v.value
            }));
        }
    }

    @wire(getRecord, {
        recordId: '$recordId',
        fields: [FIELD_API]
    })
    wiredRecord({ data }) {
        if (data && !this.isEditing) {
            this.value = data.fields.CMPL123QMS__Correct_Specification__c.value;
            this.draftValue = this.value;
        }
    }

    /* ===== View-mode CSS helpers ===== */

    get yesClass() {
        return this.value === 'Yes' ? 'selected' : '';
    }

    get noClass() {
        return this.value === 'No' ? 'selected' : '';
    }

    get naClass() {
        return this.value === 'N/A' ? 'selected' : '';
    }

    /* ===== Actions ===== */

    handleEdit() {
        this.isEditing = true;
    }

    handleChange(event) {
        this.draftValue = event.detail.value;
    }

    handleCancel() {
        this.draftValue = this.value;
        this.isEditing = false;
    }

    handleSave() {
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[FIELD_API.fieldApiName] = this.draftValue;

        updateRecord({ fields }).then(() => {
            this.value = this.draftValue;
            this.isEditing = false;
        });
    }
}