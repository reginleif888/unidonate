export type UniqueIdentifier = string;

export interface SelectItem {
  value: UniqueIdentifier;
  label: string;
}

export interface School {
  id: string;
  name: string;
  image: string;
  description: string;
  studentsCount: string;
}

export interface Student {
  id: string;
  name: string;
  age: string;
}

export interface GridItem {
  id: string;
  name: string;
  image: string;
  description: string;
}

export interface FormCategory {
  categoryId: string;
  amount: number;
}

export interface DonationFormValues {
  totalAmount: number;
  categories: FormCategory[];
}
