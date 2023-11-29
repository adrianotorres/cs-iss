import { fetchData } from "./api";

type createInssCalculatorResponse = {
  discount: string;
}

export const calculateINSSDiscount = async (salary: Number): Promise<createInssCalculatorResponse> =>{
  const response = (await fetchData(
    '/inss/calculate',
    'POST',
    { salary }
  ));

  return {
    discount: response ? response.discount : 0,
  } as createInssCalculatorResponse
}