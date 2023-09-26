CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  date_of_birth DATE NOT NULL,
);

CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admitted_at TIMESTAMP NOT NULL,
  patient_id INTEGER NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE treatments (
  id SERIAL PRIMARY KEY,
  type VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
);

CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  total_amount DECIMAL NOT NULL,
  generated_at TIMESTAMP NOT NULL,
  payed_at TIMESTAMP NOT NULL,
  medical_history_id INTEGER NOT NULL,
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL NOT NULL,
  quantity INTEGER,
  total_price DECIMAL,
  invoive_id INTEGER,
  treatment_id INTEGER,
  FOREIGN KEY (invoive_id) REFERENCES invoices(id),
  FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE TABLE  medical_histories_treatments  (
   medical_histories_id  int,
   treatments_id  int,
  PRIMARY KEY ( medical_histories_id ,  treatments_id ),
  FOREIGN KEY ( medical_histories_id ) REFERENCES  medical_histories  ( id );
  FOREIGN KEY ( treatments_id ) REFERENCES  treatments  ( id );
);

/*INDEXES ON FOREIGN KEY*/
CREATE INDEX ndx_medhistories_patient_id ON medical_histories(patient_id);
CREATE INDEX ndx_medhistories_id ON medical_histories(id);
CREATE INDEX ndx_invoice_items_invoice_id ON invoice_items(invoice_id);
CREATE INDEX ndx_invoice_items_treatment_id ON invoice_items(treatment_id);
CREATE INDEX ndx_medhistories_treatments_med_histories_id ON medical_histories_treatments(medical_histories_id);
CREATE INDEX ndx_medhistories_treatments_treatments_id ON medical_histories_treatments(treatments_id);