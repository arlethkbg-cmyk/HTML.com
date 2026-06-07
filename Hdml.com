<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Love Heart</title>
  <style>
   * { margin: 0; padding 0; box-sizing: border-box; }
   body { background: #000; overflow: hidden; display: flex; align-items: center; justify-content: center; heigth 100vh }
   canvas { display: bock; }
 </style>
</head>
<body>

   <canvas id="c"></canvas>

   <script>
     const canvas =
   document.getElementByld("c"); 
       const ctx = canvas.getContext("2d");

       canvas.width = window.innerWidth;  
       canvas.height = window.innerHeight;

       let angle = 0;
       const NUM_STEPS = 70;
       const SCALE = 13; //
       const TEXT = "I love you"; //

       function heartX(t) { return 16 * Math.pow(Math.sin(t), 3); }
       function heartY(t) { return 13*Math.cos(t) - 5*Math.cos(2*t) - 2*Math.cos(3*t) - Math.cos(4*t); }

       function draw() { ctx.clearRect(0, 0, canvas.width, canvas.height);
         const cx = canvas.width / 2;
         const cy = canvas.height / 2;

         ctx.font = "bold 12px Arial"; //
         ctx.textAlign = "center";
         ctx.textBaseline = "middle"; //

        for (let i = 0; i < NUM_STEPS; i++) {
           const t = (i / NUM_STEPS) * Math.PI * 2 + angle;
           const x = cx + heartX(t) * SCALE;
           const y = cy - heartY(t) * SCALE; //

           // Un degradado rosa/rojo hermoso
                ctx.fillStyle = `hsl(${(i / NUM_STEPS) * 60 + 330}, 100%, 60%)`; 
                ctx.fillText(TEXT, x, y);
            }

            angle += 0.01; // 
            requestAnimationFrame(draw);
        }

        draw();

        window.addEventListener("resize", () => {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
        });
    </script>
</body>
</html>
