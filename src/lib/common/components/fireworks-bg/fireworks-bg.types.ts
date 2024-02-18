export interface Particle {
  x: number;
  y: number;
  color: string;
  radius: number;
  endPos: { x: number; y: number };
  draw: () => void;
}

export interface Circle {
  x: number;
  y: number;
  color: string;
  radius: number;
  alpha: number;
  lineWidth: number;
  draw: () => void;
}
