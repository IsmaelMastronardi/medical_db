CREATE TABLE patients (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(100) NOT NULL,
date_of_birth date);


CREATE TABLE medical_histories(
id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
admitted_at TIMESTAMP,
pattient_id INT,
status VARCHAR(50))
CONSTRAINT fk_patient_id FOREIGN KEY (patient_id) REFERENCES patients(id)
;


CREATE TABLE treatments (
id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
type VARCHAR(100) NOT NULL,
name VARCHAR(100) NOT NULL);


CREATE TABLE invoices (
id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
total_amount DECIMAL(10,2) NOT NULL,
generated_at TIMESTAMP,
payed_at TIMESTAMP,
medical_history_id INT)
CONSTRAINT
    fk_medical_histories FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
;


CREATE TABLE invoice_items(
id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
unit_price DECIMAL(10,2) NOT NULL,
quantity INT NOT NULL,
total_price DECIMAL(10,2) NOT NULL,
invoice_Id INT NOT NULL,
treatment_id INT )
CONSTRAINT fk_invoice_id FOREIGN KEY (invoice_id) REFERENCES invoices(id),
CONSTRAINT fk_treatment FOREIGN KEY (treatment_id) REFERENCES treatments(id)
;

CREATE TABLE treatments_medical_histories (
medical_histories_id INT REFERENCES medical_histories(id),
treatments_id INT REFERENCES treatments(id),
PRIMARY KEY (medical_histories_id, treatments_id))
CONSTRAINT treatments_medical_histories_medical_histories_id_fkey FOREIGN KEY (medical_histories_id) REFERENCES medical_histories(id),
CONSTRAINT treatments_medical_histories_treatments_id_fkey FOREIGN KEY (treatments_id) REFERENCES treatments(id)
;



CREATE INDEX idx_patient_id ON medical_histories(patient_id);


CREATE INDEX idx_medical_history ON invoices(medical_history_id);

CREATE INDEX idx_invoice ON invoice_items(invoice_id);

CREATE INDEX idx_treatment ON invoice_items(treatment_id);


CREATE INDEX idx_medical_histories ON treatments_medical_histories(medical_histories_id);

CREATE INDEX idx_treatments ON treatments_medical_histories(treatments_id);