use v6;
use Box2D;
use NativeCall;
use Test;

plan 1;

# Define the gravity vector.
my $gravity = Box2D::Vec2.new(0.0, -10.0);

# Construct a world object, which will hold and simulate the rigid bodies.
my $world = Box2D::World.new(:$gravity);

# Define the ground body.
my $groundBodyDef = Box2D::BodyDef.new;
$groundBodyDef.position.Set(0.0, -10.0);

# Call the body factory which allocates memory for the ground body
# from a pool and creates the ground box shape (also from a pool).
# The body is also added to the world.
my $groundBody = $world.CreateBody($groundBodyDef);

# Define the ground box shape.
my $groundBox = Box2D::PolygonShape.new;

# The extents are the half-widths of the box.
$groundBox.SetAsBox(50.0, 10.0);

# Add the ground fixture to the ground body.
$groundBody.CreateFixture($groundBox, 0.0);

=finish
# Define the dynamic body. We set its position and call the body factory.
b2BodyDef bodyDef;
bodyDef.type = b2_dynamicBody;
bodyDef.position.Set(0.0f, 4.0f);
b2Body* body = world.CreateBody(&bodyDef);

# Define another box shape for our dynamic body.
b2PolygonShape dynamicBox;
dynamicBox.SetAsBox(1.0f, 1.0f);

# Define the dynamic body fixture.
b2FixtureDef fixtureDef;
fixtureDef.shape = &dynamicBox;

# Set the box density to be non-zero, so it will be dynamic.
fixtureDef.density = 1.0f;

# Override the default friction.
fixtureDef.friction = 0.3f;

# Add the shape to the body.
body->CreateFixture(&fixtureDef);

# Prepare for simulation. Typically we use a time step of 1/60 of a
# second (60Hz) and 10 iterations. This provides a high quality simulation
# in most game scenarios.
float32 timeStep = 1.0f / 60.0f;
int32 velocityIterations = 6;
int32 positionIterations = 2;

# This is our little game loop.
for (int32 i = 0; i < 60; ++i)
{
    # Instruct the world to perform a single step of simulation.
    # It is generally best to keep the time step and iterations fixed.
    world.Step(timeStep, velocityIterations, positionIterations);

    # Now print the position and angle of the body.
    b2Vec2 position = body->GetPosition();
    float32 angle = body->GetAngle();

    printf("%4.2f %4.2f %4.2f\n", position.x, position.y, angle);
}

# When the world destructor is called, all bodies and joints are freed. This can
# create orphaned pointers, so be careful about your world management.
