import Inputmask from 'inputmask'

export const currencyMask = (): Inputmask => {
  return new Inputmask("currency", {
    radixPoint: ",",
    alias: "numeric",
    groupSeparator: ".",
    autoGroup: true,
    digits: 2,
    prefix: "R$ ",
    rightAlign: false,
    removeMaskOnSubmit: true,
  });
}