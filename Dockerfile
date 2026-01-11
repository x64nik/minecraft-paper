# Use a lightweight OpenJDK image. 
# Change '21-jre-jammy' to '17-jre-jammy' if you are on an older MC version.
FROM eclipse-temurin:21-jre-jammy

# Set the working directory inside the container
WORKDIR /minecraft

# Install bash and curl for potential plugin needs
RUN apt-get update && apt-get install -y bash && rm -rf /var/lib/apt/lists/*

# Copy all your files into the container
COPY . .

# Ensure the eula is accepted (Minecraft won't start without this)
# If your local eula.txt is already 'true', this line doesn't hurt.
RUN echo "eula=true" > eula.txt

# Expose the default Minecraft port
EXPOSE 25565

# Set environment variables for memory (can be overridden at runtime)
ENV MEM_HEAP="8G"

# Run the server
# 'nogui' is added to prevent Minecraft from trying to open a window
CMD java -Xms${MEM_HEAP} -Xmx${MEM_HEAP} -jar server.jar nogui