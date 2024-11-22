import { DerivableInput, MiddlewareState } from "../types";

declare function read<T>(input: DerivableInput<T>, state: MiddlewareState): T;

export default read;
