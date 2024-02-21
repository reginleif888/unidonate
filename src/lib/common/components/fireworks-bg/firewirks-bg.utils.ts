import anime from "animejs";
import type { Circle, Particle } from "./fireworks-bg.types";

interface Coords {
  x: number;
  y: number;
}

function getParticleDirection(particle: Particle): { x: number; y: number } {
  const angle: number = (anime.random(0, 360) * Math.PI) / 180;
  const value: number = anime.random(50, 180);
  const radius: number = [-1, 1][anime.random(0, 1)] * value;
  return {
    x: particle.x + radius * Math.cos(angle),
    y: particle.y + radius * Math.sin(angle),
  };
}

interface CreateParticleParams extends Coords {
  colors: Array<string>;
  ctx: CanvasRenderingContext2D;
}

export function createParticle({
  x,
  y,
  colors,
  ctx,
}: CreateParticleParams): Particle {
  const particle: Particle = {
    x: x,
    y: y,
    color: colors[anime.random(0, colors.length - 1)],
    radius: anime.random(16, 32),
    endPos: { x: 0, y: 0 },
    draw: function () {
      if (ctx) {
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.radius, 0, 2 * Math.PI, true);
        ctx.fillStyle = this.color;
        ctx.fill();
      }
    },
  };

  particle.endPos = getParticleDirection(particle);

  return particle;
}

interface CreateCircleParams extends Coords {
  ctx: CanvasRenderingContext2D;
}

export function createCircle({ x, y, ctx }: CreateCircleParams): Circle {
  const circle: Circle = {
    x: x,
    y: y,
    color: "#FFF",
    radius: 0.1,
    alpha: 0.5,
    lineWidth: 6,
    draw: function () {
      if (ctx) {
        ctx.globalAlpha = this.alpha;
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.radius, 0, 2 * Math.PI, true);
        ctx.lineWidth = this.lineWidth;
        ctx.strokeStyle = this.color;
        ctx.stroke();
        ctx.globalAlpha = 1;
      }
    },
  };

  return circle;
}

function renderParticle(animeInstance: anime.AnimeInstance): void {
  animeInstance.animatables.forEach((animatable) => {
    (animatable.target as unknown as Particle | Circle).draw();
  });
}

interface AnimateParticles extends Coords {
  colors: Array<string>;
  ctx: CanvasRenderingContext2D;
  numberOfParticles: number;
}

export const animeInstance = anime;

export function animateParticles({
  x,
  y,
  colors,
  ctx,
  numberOfParticles,
}: AnimateParticles): void {
  const circle: Circle = createCircle({ x, y, ctx });

  const particles: Particle[] = Array.from({ length: numberOfParticles }, () =>
    createParticle({ x, y, colors, ctx })
  );

  anime
    .timeline()
    .add({
      targets: particles,
      x: (particle: Particle) => particle.endPos.x,
      y: (particle: Particle) => particle.endPos.y,
      radius: 0.1,
      duration: anime.random(1200, 1800),
      easing: "easeOutExpo",
      update: renderParticle,
    })
    .add(
      {
        targets: circle,
        radius: anime.random(80, 160),
        lineWidth: 0,
        alpha: {
          value: 0,
          easing: "linear",
          duration: anime.random(600, 800),
        },
        duration: anime.random(1200, 1800),
        easing: "easeOutExpo",
        update: renderParticle,
      },
      0
    );
}
