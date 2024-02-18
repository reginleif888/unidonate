import type { FormDonation } from "./types";

export const donationsMock: Array<FormDonation> = [
  {
    id: "1d01a1a8-c7b8-4d46-9dd3-b9876549916f",
    transactionId:
      "2c5445d0d61365082e78d69203db75307a4493e35986fe1f8120257701151527",
    amount: "0.000021",
    paymentAddress: "1d01vv8-c7b28-4dd6-9dd3-b98165499ax16f",
    allocations: {
      LunchAndSnacks: "25",
      SchoolSupplies: "25",
      DesignAndDevelopment: "25",
      TeacherSupport: "25",
    },
  },
  // Additional 19 objects
  ...Array.from({ length: 50 }, (_, i) => ({
    id: `1d01a1a8-c7b8-4d46-9dd3-b9876549916f-${i + 2}`,
    transactionId: `2c5445d0d61365082e78d69203db75307a4493e35986fe1f8-${Math.random().toString(36).substr(2, 34)}`,
    amount: (Math.random() * 0.0001 + 0.00001).toFixed(6),
    paymentAddress: `pa-${Math.random().toString(36).substr(2, 18)}`,
    allocations: {
      LunchAndSnacks: (Math.random() * 100).toFixed(0),
      SchoolSupplies: (Math.random() * 100).toFixed(0),
      DesignAndDevelopment: (Math.random() * 100).toFixed(0),
      TeacherSupport: (Math.random() * 100).toFixed(0),
    },
  })),
];
