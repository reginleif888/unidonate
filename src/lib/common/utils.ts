export const debounce = <T extends (...args: any[]) => any>(
  fn: T,
  ms: number
): [(...args: Parameters<T>) => Promise<ReturnType<T>>, () => void] => {
  let timer: NodeJS.Timeout;

  const debouncedFunc = (...args: Parameters<T>): Promise<ReturnType<T>> =>
    new Promise((resolve) => {
      if (timer) {
        clearTimeout(timer);
      }

      timer = setTimeout(() => {
        resolve(fn(...args));
      }, ms);
    });

  const dispose = () => clearTimeout(timer);

  return [debouncedFunc, dispose];
};
